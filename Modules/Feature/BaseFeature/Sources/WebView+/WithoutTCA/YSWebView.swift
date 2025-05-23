//
//  YSWebView.swift
//  BaseFeatureInterface
//
//  Created by root0 on 3/18/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import SwiftUI
import WebKit
import UIKit
import BaseFeatureInterface

protocol YSWebViewDelegate {

}

public struct YSWebView: UIViewRepresentable {

    let url: URL?

    @ObservedObject var store: YSWebViewStore = .init()

    public init(url: URL? = nil) {
        self.url = url
    }

    @MainActor
    public func makeUIView(context: Context) -> WKWebView {
        guard let url = url else { return WKWebView() }

        let webView = WKWebView(frame: .zero, configuration: .init())// store.webService.createWebView()
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        webView.scrollView.delegate = context.coordinator

        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60 * 60 * 10)
        webView.load(request)

        Task {
//            await store.action(.registerBridgeHandlers(for: webView, sender: context.coordinator))
        }

        return webView
    }

    public func updateUIView(_ webView: WKWebView, context: Context) {
        print("## YSWebViewRepresentable UpdateUIView ##")
        if context.coordinator.currentPage != store.state.webPage {
            print("** YSWebViewRepresentable WebPage Changed **")
            load(in: webView)
            context.coordinator.currentPage = store.state.webPage
        }
    }

    func load(in web: WKWebView) {
        let request = URLRequest(url: url!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60 * 60 * 10)
        web.load(request)
    }

    func getUserAgent(_ webview: WKWebView) async -> String {
        do {
            let result = try await webview.evaluateJavaScript("navigator.userAgent")
            return result as? String ?? ""
        } catch {
            print("ERROR Get WebView UserAgent")
            return ""
        }
    }

    func putInfomation(_ webview: WKWebView) async -> String {
        let userAgentString = await getUserAgent(webview)

        let userAgentStr: String = "A"
        let userAgentService: String = "b"
        let deviceId: String = ""
        let appVersion: String = "1.0.0"
        let osVersion: String = UIDevice.current.systemVersion

        await store.action(.saveUserAgent(userAgentString))

        return userAgentString
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

        let contentController = WKUserContentController()
        config.userContentController = contentController

        return config
    }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    public class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate {
        var parent: YSWebView
        var currentPage: YSWebViewURLRequest?

        init(parent: YSWebView) {
            self.parent = parent
        }


        // MARK: YSWebView Coordinator Delegate
        // MARK: WKUIDelegate
        public func webViewDidClose(_ webView: WKWebView) {

        }
        public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping @MainActor () -> Void) {

        }
        public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping @MainActor (Bool) -> Void) {

        }
        public func webView(
            _ webView: WKWebView,
            runJavaScriptTextInputPanelWithPrompt prompt: String,
            defaultText: String?, initiatedByFrame frame: WKFrameInfo,
            completionHandler: @escaping @MainActor (String?) -> Void) {

        }

        // MARK: WKNavigationDelegate
        /// 웹 페이지 시작
        public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

        }
        /// 웹 페이지 로드 완료
        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        }
        public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {

        }
        public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: any Error) {

        }
        @MainActor
        public func webView(
            _ webView: WKWebView,
            didReceive challenge: URLAuthenticationChallenge,
            completionHandler: @escaping @MainActor (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {

            DispatchQueue.global().async {
                let cred = URLCredential(trust: challenge.protectionSpace.serverTrust!)
                completionHandler(.useCredential, cred)
            }
        }

        public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
            if let host = navigationAction.request.url?.host, host == "www.instagram.com" {
                webView.allowsBackForwardNavigationGestures = true
            }
            return .allow
        }

        public func webView(
            _ webView: WKWebView,
            requestMediaCapturePermissionFor origin: WKSecurityOrigin,
            initiatedByFrame frame: WKFrameInfo,
            type: WKMediaCaptureType,
            decisionHandler: @escaping @MainActor (WKPermissionDecision) -> Void) {
            decisionHandler(.prompt)
        }
        public func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let verticalIndicator = scrollView.subviews[scrollView.subviews.count - 1] as? UIImageView
            verticalIndicator?.backgroundColor = .black
        }
    }
}


#Preview {
    YSWebView(url: URL(string: "www.naver.com")!)
}
