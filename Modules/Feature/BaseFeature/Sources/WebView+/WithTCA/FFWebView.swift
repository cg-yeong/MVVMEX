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
import WebServiceInterface
import SwiftyJSON
import AdSupport

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
            store.send(.onAppear)
            store.send(.setDelegateBridge(context.coordinator))
            store.send(.registerBridgeHandlers(for: webView, sender: context.coordinator))
        }

        return webView
    }

    public func updateUIView(_ webView: WKWebView, context: Context) {
        print("## FFWebViewRepresentable UpdateUIView ##")
        if store.toLoadURL?.url == nil {
            print("** webview imsi registerhandler")
//            store.send(.registerBridgeHandlers(for: webView, sender: context.coordinator))
        }
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
        }

        /// WKNavigation Delegate 페이지 로딩시 네트워크 상태 체크
        public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

            // ver.Yeoboya: 개발서버인 경우(://devm), Reachability Cellular, Wifi, 사내망체크API -> true : false(실서버로 이동; Startpage UserDefaults 제거) popup이면 내려주고
            // ver.Honey: get서버리스트[모델] 받아서 뷰 만들어주고 서버이동하면 앱 서버 URL 변경; Userdefaults URL 설정 변경; 로그인데이터 지우기; 앱 재시작;

        }

        public func getAdId(message: JSON, _ callback: (Any?) -> Void) {
            print("** \(#file) getAdId : \(message)")
            let adId = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            print("** \(#file) sendAdId: \(adId)")
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
