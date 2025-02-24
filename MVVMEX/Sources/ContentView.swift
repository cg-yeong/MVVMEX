import SwiftUI
import BaseFeature
import CoordinatorFeatureInterface

public struct ContentView: View {
    @EnvironmentObject var coordinator: Coordinator
    public init() {}

    public var body: some View {
        NavigationStack(path: coordinator.bindingPath) {
            let viewModel = BaseViewModel(coordinator: coordinator)
            FeatureSelectView(viewModel: viewModel)
                .modifier(CoordinatorModifier(coordinator, with: AppDelegate.container))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
