import SwiftUI
import BaseFeature

public struct ContentView: View {
    public init() {}

    public var body: some View {
        Text("ContentView")
            .font(.title)

        FeatureSelectView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
