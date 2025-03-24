//
//  JavascriptBridgeService.swift
//  BaseFeature
//
//  Created by root0 on 3/24/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import SwiftyJSON
import WebKit
import BaseFeatureInterface

public class JavascriptBridgeService: NSObject {

    weak var responseDelegate: BridgeResponseDelegate? {
        didSet {
            initBridgeHandlers()
        }
    }
    var bridge: WebViewJavascriptBridge?
    var bridgeHandlers: [String: (JSON) -> Void]? = [:]

    var responseHandlerName: String = "callFromWeb"
    var requesthandlerName: String = "$.webScript"

    func createWebView() -> WKWebView {
        let webView = WKWebView(frame: .zero, configuration: makeWebViewConfiguration())
        // uiDelegate, scrollView.delegate, navigationDelegate
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.bounces = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsLinkPreview = false
        webView.allowsBackForwardNavigationGestures = true

        if #available(iOS 16.4, *) {
            webView.isInspectable = true
        }

        putInformation(webView) { customUserAgent in
            webView.customUserAgent = customUserAgent
        }

        return webView
    }

    func registerHandlers(for webView: WKWebView, sender: WKUIDelegate) {
        bridge = WebViewJavascriptBridge(forWebView: webView)
        bridge?.setWebViewDelegate(sender)

        let handler: WVJBHandler = { [weak self] (data, responseCallback) -> Void in
            let json = JSON(data as Any)
            print("수신 브릿지 with 데이터:\n\(json)\n")

            if let router = self?.bridgeHandlers?[json["cmd"].stringValue] {
                router(json)
            } else {

            }
        }
        bridge?.registerHandler(responseHandlerName, handler: handler)
        print("RegisterHandlers")
    }

    func getUserAgent(_ webView: WKWebView, completion: ((String) -> Void)? = nil) {
        webView.evaluateJavaScript("navigator.userAgent") { (result, error) in
            guard let completion = completion else { return }

            if let result = result as? String {
                completion(result)
            } else {
                completion("")
                print("## WebView에서 UserAgent 가져오지 못했다.")
            }
        }
    }
    func putInformation(_ webView: WKWebView, completion: ((String) -> Void)? = nil) {
        let userAgent = UserDefaults.standard.object(forKey: "userAgent") as? String

        if let userAgent = userAgent {
            completion?(userAgent)
            return
        }

        getUserAgent(webView) { userAgentString in
            let userAgentStr: String = "packageName" // 패키지명 like "HONEY"
            let userAgentDevice: String = "b" // android: a, ios: b
            let deviceID: String = UIDevice.current.identifierForVendor!.uuidString // 변하지 않게 키체인에서
            let deviceToken: String = "" // FCM Token or APNS token
            let appVersion: String = "1.0"
            let osVersion: String = UIDevice.current.systemVersion

            let userAgnetArray = [
                userAgentStr, userAgentDevice, deviceID, deviceToken, appVersion, osVersion
            ]

            let modelName = "(\(""))" // 디바이스 모델
            // TODO: Save at UserDefaults
            let customUserAgent = userAgentString + modelName + userAgnetArray.joined(separator: "|")

            completion?(customUserAgent)
        }
    }

    func makeWebViewConfiguration() -> WKWebViewConfiguration {
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = true

        let config = WKWebViewConfiguration()
        config.processPool = WKProcessPool()
        config.preferences = preferences
        config.websiteDataStore = .default()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = .all

        let content = WKUserContentController()
        config.userContentController = content

        return config
    }
}

extension JavascriptBridgeService {
    func initBridgeHandlers() {
        bridgeHandlers?[BridgeResponseCMD.stateLogin.rawValue] = responseDelegate?.stateLogin
        bridgeHandlers?[BridgeResponseCMD.socialLogin.rawValue] = responseDelegate?.socialLogin
        bridgeHandlers?[BridgeResponseCMD.finishWin.rawValue] = responseDelegate?.finishWin
        bridgeHandlers?[BridgeResponseCMD.openWin.rawValue] = responseDelegate?.openWin
    }
}



