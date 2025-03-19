//
//  YSWebViewStore.swift
//  BaseFeatureInterface
//
//  Created by root0 on 3/18/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import SwiftUI
import BaseFeatureInterface

public class YSWebViewStore: StoreProtocol {
    public typealias State = WebViewState

    public typealias Action = WebAction

    public struct WebViewState: Equatable {
        var customUserAgent: String = ""
    }

    public enum WebAction {
        case onAppear
        case registerBridgeHandlers(WebViewJavascriptBridge)
        case saveUserAgent(String)
    }

    @Published private(set) var state: WebViewState = .init()

    public func action(_ action: Action) async {
        switch action {
        case .onAppear:
            break
        case .registerBridgeHandlers:
            break
        default:
            break
        }
    }

    func registerHandlers() {

    }

}
