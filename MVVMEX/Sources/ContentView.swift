import SwiftUI
import BaseFeatureInterface
import BaseFeature
import CoordinatorFeatureInterface

import AppConfigDomainInterface
import AppConfigDomain

public struct ContentView: View {
    @EnvironmentObject var coordinator: Coordinator
    
    public init() {}

    public var body: some View {
        NavigationStack(path: coordinator.bindingPath) {
            let viewModel = DIContainer.shared.makeBaseViewModel(coordinator: coordinator)
            FeatureSelectView(viewModel: viewModel)
                .modifier(CoordinatorModifier(coordinator, with: AppDelegate.container))
                .task {
                    await viewModel.fetchWebSetting()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
