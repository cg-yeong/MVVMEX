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

public class YSWebViewStore: StoreProtocol {
    public typealias State = WebViewState

    public typealias Action = WebAction

    public struct WebViewState: Equatable {
        var customUserAgent: String = ""
        var webPage: YSWebViewURLRequest = .login
    }

    public struct WebBridgeState: Equatable {
        var bridge: WebViewJavascriptBridge? = nil
    }

    public enum WebAction {
        case onAppear
        case registerBridgeHandlers(WKNavigationDelegate)
        case saveUserAgent(String)
    }

    @Published private(set) var state: WebViewState = .init()

    public func action(_ action: Action) async {
        switch action {
        case .onAppear:
            print("YSwebview on appear")
            break
        case .registerBridgeHandlers:
            print("YSwebview register handlers")
            state.webPage = .mypage
            registerHandlers()
        default:
            break
        }
    }

    func registerHandlers() {

    }

}
