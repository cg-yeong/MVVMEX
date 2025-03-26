import SwiftUI
import WebKit
import BaseFeatureInterface
import BaseFeature
import UIKit
import AppConfigDomainInterface
import AppConfigDomain

public struct ContentView: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var isIntro = true {
        didSet {
            print("isIntro: \(isIntro)")
        }
    }
    public init() {}

    public var body: some View {
        ZStack {
            NavigationStack(path: coordinator.bindingPath) {
                let store = AppDelegate.container.makeFFWebStore(coordinator: coordinator)
//                FFWebView(store: store)
//                    .modifier(CoordinatorModifier(coordinator, with: AppDelegate.container))


                let viewModel = DIContainer.shared.makeBaseViewModel(coordinator: coordinator)
//                FeatureSelectView(viewModel: viewModel)
                FFWebView(store: store)
                    .modifier(CoordinatorModifier(coordinator, with: AppDelegate.container))
                    .task {
                        await viewModel.fetchWebSetting()
//                        coordinator.push(.webView("navigationYeoboya"))
                    }

            }

            /*
            OnBoardingTabView(isOnBoarding: $isIntro)
                .opacity(isIntro ? 1 : 0)
                .id(coordinator.key)
            */
        }
        .onChange(of: coordinator.key) { oldValue, newValue in
            if oldValue != newValue {
                isIntro = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct SAWebView: UIViewRepresentable {
    var url: URL? = nil

    public init(url: URL? = nil) {
        self.url = url
    }

    @MainActor
    func makeUIView(context: Context) -> WKWebView {
        guard let url = url else { return WKWebView() }
        let webView = WKWebView(frame: .zero, configuration: .init())
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        webView.scrollView.delegate = context.coordinator

        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60 * 60 * 10)
        webView.load(request)

        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        print("## YSWebViewRepresentable UpdateUIView ##")
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate {
        var parent: SAWebView

        init(parent: SAWebView) {
            self.parent = parent
        }
    }
}
