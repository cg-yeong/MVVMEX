//
//  YSWebViewStore.swift
//  BaseFeatureInterface
//
//  Created by root0 on 3/18/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import SwiftUI
import BaseFeatureInterface
import WebKit
import WebService

public class YSWebViewStore: StoreProtocol {
    public typealias State = WebViewState

    public typealias Action = WebAction

    public struct WebViewState: Equatable {
        var customUserAgent: String = ""
        var webPage: YSWebViewURLRequest = .login
    }

    public struct WebBridgeState: Equatable {
//        var bridge: WebViewJavascriptBridge? = nil
    }

    public enum WebAction {
        case onAppear
        case registerBridgeHandlers(for: WKWebView, sender: WKUIDelegate)
        case saveUserAgent(String)
    }

    @Published private(set) var state: WebViewState = .init()
    
    private(set) var webService: JavascriptBridgeService = .init()

    @MainActor
    public func action(_ action: Action) async {
        switch action {
        case .onAppear:
            print("YSwebview on appear")
            break
        case .registerBridgeHandlers(let webView, let sender):
            webService.registerHandlers(for: webView, sender: sender)
        case .saveUserAgent(let userAgent):
            break
        default:
            break
        }
    }

    func registerHandlers() {

    }

}
