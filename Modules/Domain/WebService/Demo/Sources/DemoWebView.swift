//
//  DemoWebView.swift
//  WebServiceDemo
//
//  Created by root0 on 3/26/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import SwiftUI
import WebKit
import UIKit
import SwiftyJSON
import WebServiceInterface
import WebService

struct DemoWebView: UIViewRepresentable {
    typealias UIViewType = WKWebView

    var url: URL?
    let webservice: JavascriptBridgeService = JSBridgeServiceDependency.liveValue

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView.baseWKWebView
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        webView.scrollView.delegate = context.coordinator
        if let url = url {
            let request = URLRequest(url: url)

            webView.load(request)
        } else {
            let request = URLRequest(url: URL(string: "")!)
            webView.load(request)

            webservice.registerHandlers(for: webView, sender: context.coordinator)
        }

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
//        if context.coordinator.currentURL !=
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate, BridgeResponseDelegate {

        var parent: DemoWebView
        var currentURL: URL?

        init(parent: DemoWebView, currentURL: URL? = nil) {
            self.parent = parent
            self.currentURL = currentURL
        }

        /// WKNavigation Delegate 페이지 로딩시 네트워크 상태 체크 -> 서버상태 체크
        public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

        }

        func sLogin(message: JSON) {
            // social Login
        }
    }
}
