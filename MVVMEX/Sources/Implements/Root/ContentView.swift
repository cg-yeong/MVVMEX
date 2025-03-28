import SwiftUI
import WebKit
import BaseFeatureInterface
import BaseFeature
import UIKit
import AppConfigDomainInterface
import AppConfigDomain

public struct ContentView: View {
    @EnvironmentObject var coordinator: Coordinator
    @EnvironmentObject var hudState: HudState
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

                Button {
                    hudState.show(title: "Five Starts", systemImage: "star.fill")
                } label: {
                    Label {
                        Text("Show HUD")
                    } icon: {
                        Color.blue.frame(width: 50, height: 50)
                    }

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


