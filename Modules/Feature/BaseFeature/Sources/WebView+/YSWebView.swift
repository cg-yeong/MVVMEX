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

    public func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    public func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }


    public func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    public class Coordinator: NSObject, WKNavigationDelegate {
        var parent: YSWebView

        init(parent: YSWebView) {
            self.parent = parent
        }

        
    }
}

#Preview {
    YSWebView(url: URL(string: "")!)
}
