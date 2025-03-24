//
//  FFWebView.swift
//  BaseFeature
//
//  Created by root0 on 3/21/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import SwiftUI
import WebKit
import UIKit
import BaseFeatureInterface

public struct FFWebView: UIViewRepresentable {
    public typealias UIViewType = WKWebView

//    var bridgeManager: FF

    @MainActor
    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())

        return webView
    }

    public func updateUIView(_ uiView: WKWebView, context: Context) {

    }


}

//#Preview {
//    FFWebView()
//}
