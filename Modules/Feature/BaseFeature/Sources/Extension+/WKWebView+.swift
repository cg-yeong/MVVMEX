//
//  WKWebView+.swift
//  BaseFeature
//
//  Created by root0 on 3/25/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import WebKit

public extension WKWebView {
    static var baseWebConfig = {
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
    }()

    static var baseWKWebView = {
        let webView = WKWebView(frame: .zero, configuration: baseWebConfig)
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.bounces = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsLinkPreview = false
        webView.allowsBackForwardNavigationGestures = true

        if #available(iOS 16.4, *) {
            webView.isInspectable = true
        }

        // MARK: GetUserAgent, PutInformation
        webView.evaluateJavaScript("navigator.userAgent") { (result, error) in
            if let result = result as? String {
                let userAgentString = result
                let userAgentStr: String = "" //
                let userAgentDevice: String = "" //
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

//                webView.customUserAgent = customUserAgent
            } else {
                print("## WebView에서 UserAgent 가져오지 못했다.: \(error?.localizedDescription ?? "")")
                let userAgent = UserDefaults.standard.object(forKey: "userAgent") as? String
                if let userAgent = userAgent {
//                    webView.customUserAgent = userAgent
                }
            }
        }

        return webView
    }()
}
