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

        webView.customUserAgent = putCustomUserAgent(webView)

        return webView
    }()

    static var getUserAgent: (WKWebView) -> String = { webView in
        var result = ""
        webView.evaluateJavaScript("navigator.userAgent") { (userAgent, error) in
            if let userAgent = userAgent as? String {
                result = userAgent
            } else if let error = error {
                result = ""
            } else {
                result = ""
            }
        }
        return result
    }

    /// webView.customUserAgent = putCustomUserAgent(webView) // modified
    static var putCustomUserAgent: (WKWebView) -> String = { webView in
        let userAgent: String = getUserAgent(webView)
        let serviceName: String = ""
        let userDevice: String = ""
        let deviceID: String = UIDevice.current.identifierForVendor?.uuidString ?? "" //변하지 않게 키체인에서 할수도
        let deviceToken: String = "" // FCM Token or APNS token
        let appVersion: String = ""
        let osVersion: String = UIDevice.current.systemVersion

        let modifyArray = [
            serviceName, userDevice, deviceID, deviceToken, appVersion, osVersion
        ]
        let modelName = "(\(UIDevice.modelName))"

        let modified = userAgent.contains(serviceName) ? userAgent : userAgent + modelName + modifyArray.joined(separator: "|")

        print("## CustomUserAgent: \(modified)")
        UserDefaults.standard.register(defaults: ["UserAgent": modified])
        return modified
    }
}
