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

public struct YSWebView: UIViewRepresentable {

    let url: URL
    @Binding var isLoading: Bool
    @ObservedObject var store: YSWebViewStore = .init()

    @MainActor
    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero, configuration: makeWebViewConfiguration())
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.delegate = context.coordinator
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.bounces = false
        webView.allowsLinkPreview = false
        webView.allowsBackForwardNavigationGestures = true
//        webView.keyboardDisplayRequiresUserAction = false

        Task {
            let userAgentString = await putInfomation(webView)
            webView.customUserAgent = userAgentString

//            await store.action(.registerBridgeHandlers(<#T##WebViewJavascriptBridge#>))
        }
        
        return webView
    }

    public func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }

    func makeWebViewConfiguration() -> WKWebViewConfiguration {
        let config = WKWebViewConfiguration()

        return config
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

}

extension YSWebView {
    public func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    public class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate {
        var parent: YSWebView

        init(parent: YSWebView) {
            self.parent = parent
        }

        /// 웹 페이지 시작
        public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
        }
        /// 웹 페이지 로드 완료
        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
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

        public func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let verticalIndicator = scrollView.subviews[scrollView.subviews.count - 1] as? UIImageView
            verticalIndicator?.backgroundColor = .black
        }
    }
}

#Preview {
    YSWebView(url: URL(string: "")!, isLoading: .constant(false))
}
