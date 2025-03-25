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
import ComposableArchitecture

public struct FFWebView: UIViewRepresentable {
    public typealias UIViewType = WKWebView
    /// UIKit 에서 UIHostingController.FFWebView로 열었다면 닫아줄때 remove 핸들러
    var dismiss: (() -> Void)? = nil
    var url: URL?

    let store: StoreOf<FFWebViewStore>

    public init(url: URL? = nil, store: StoreOf<FFWebViewStore>) {
        self.url = url
        self.store = store
    }

    @MainActor
    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView.baseWKWebView
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        webView.scrollView.delegate = context.coordinator

        if let url = url {

            let request = URLRequest(url: url,
                                     cachePolicy: .returnCacheDataElseLoad,
                                     timeoutInterval: 60 * 60 * 10)
            webView.load(request)
        } else {
            store.send(.registerBridgeHandlers(for: webView, sender: context.coordinator))
            store.send(.onAppear)
        }

        return webView
    }

    public func updateUIView(_ webView: WKWebView, context: Context) {
        print("## FFWebViewRepresentable UpdateUIView ##")
        print("## webView.url: \(webView.url)")
        print("## store.toLoadURL: \(store.toLoadURL?.url)")
        if context.coordinator.currentURL != store.toLoadURL?.url {
            load(in: webView)
            print("&& Changed &&")
            context.coordinator.currentURL = store.toLoadURL?.url
        }
    }

    func load(in web: WKWebView) {
        // URLRequest(url: store.webPage.baseURL)
        if let request = store.toLoadURL {
            web.load(request)
        }
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, store: store)
    }

    public class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate, BridgeResponseDelegate {

        var parent: FFWebView
        var currentURL: URL?
        var store: StoreOf<FFWebViewStore>

        init(parent: FFWebView, store: StoreOf<FFWebViewStore>) {
            self.parent = parent
            self.store = store
            super.init()

            self.store.send(.setDelegateBridge(self))
        }
    }

}

//#Preview {
//    let store = StoreOf<FFWebViewStore>(initialState: FFWebViewStore.State()) {
//        FFWebViewStore()
//    }
//    FFWebView(store: store )
//}





extension FFWebView {
    static func makeHosting(store: StoreOf<FFWebViewStore>) -> UIHostingController<FFWebView> {

        let hosting = UIHostingController(rootView: FFWebView(store: store))
        hosting.view.backgroundColor = .blue.withAlphaComponent(0.3)
        hosting.rootView.dismiss = {
            hosting.remove()
        }

        return hosting
    }
    static func addView(dependency: StoreOf<FFWebViewStore>, on: UIViewController, container: UIView) {
        let hosting = Self.makeHosting(store: dependency)

        on.add(child: hosting, container: container)

        hosting.view.removeConstraints([
            hosting.view.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor),
            hosting.view.trailingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.trailingAnchor),
            hosting.view.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor),
            hosting.view.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            hosting.view.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor),
            hosting.view.trailingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.trailingAnchor),
            hosting.view.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor),
            hosting.view.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
