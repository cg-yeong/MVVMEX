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

    public typealias Action = UserAction

    public struct WebViewState: Equatable {
        
    }

    public enum UserAction: Equatable {

    }

    @Published private(set) var state: WebViewState = .init()

    public func action(_ action: UserAction) async {

    }

}
