//
//  FFWebViewStore.swift
//  BaseFeature
//
//  Created by root0 on 3/21/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import SwiftUI
import WebKit
import ComposableArchitecture
import BaseFeatureInterface
import Dependencies
import WebServiceInterface
import WebService

@Reducer
public struct FFWebViewStore: Reducer {

    @Dependency(\.javascriptBridgeService) public var webService

    @ObservableState
    public struct State: Equatable {
        var toLoadURL: URLRequest?
        public init() {}
    }

    public enum Action {
        case onAppear
        case directURL(String)
        case registerBridgeHandlers(for: WKWebView, sender: WKUIDelegate)
        case setDelegateBridge(BridgeResponseDelegate)
    }

    public init() {
    }

    
    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onAppear:
            return .run { send in
                await send(.directURL("https://m.naver.com"))
//                try await Task.sleep(nanoseconds: 3 * 1_000_000_000)
            }

        case .directURL(let absolutePath):
            let request = URLRequest(url: URL(string: absolutePath)!,
                                     cachePolicy: .returnCacheDataElseLoad,
                                     timeoutInterval: 60 * 60 * 10)
            state.toLoadURL = request
            return .none

        case .registerBridgeHandlers(let webView, let sender):
            return .run { @MainActor _ in
                webService.registerHandlers(for: webView, sender: sender)
                print("## Set registerHandler to Context Coordinator")
            }
//            webService.registerHandlers(for: webView, sender: sender)
//            return .none

        case .setDelegateBridge(let object):
            return .run { _ in
                webService.responseDelegate = object
                print("## Set ResponseDelegate to Context Coordinator")
            }
//            webService.responseDelegate = object
//            return .none

        }
    }
}


