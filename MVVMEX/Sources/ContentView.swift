import SwiftUI
import BaseFeatureInterface
import BaseFeature
import CoordinatorFeatureInterface

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
                let viewModel = DIContainer.shared.makeBaseViewModel(coordinator: coordinator)
                FeatureSelectView(viewModel: viewModel)
                    .modifier(CoordinatorModifier(coordinator, with: AppDelegate.container))
                    .task {
                        await viewModel.fetchWebSetting()
                    }
            }

            OnBoarding(isIntro: $isIntro)
                .opacity(isIntro ? 1 : 0)
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
