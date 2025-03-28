//
//  HudSceneView.swift
//  BaseFeature
//
//  Created by root0 on 3/27/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import SwiftUI

final public class HudState: ObservableObject {
    @Published var isPresented: Bool = false
    private(set) var title: String = ""
    private(set) var systemImage: String = ""

    public init() {}

    public func show(title: String, systemImage: String) {
        self.title = title
        self.systemImage = systemImage
        isPresented.toggle()
    }
}

public struct HudSceneView: View {
    @EnvironmentObject var hudState: HudState
    @Namespace var animation

    public init() {
        
    }
    public var body: some View {
        Color.clear
            .ignoresSafeArea(.all)
            .hud(isPresented: $hudState.isPresented) {
                Label(hudState.title, systemImage: hudState.systemImage)
                    .foregroundStyle(.white)
                    .frame(width: 120)

            }
    }
}


#Preview {
    HudSceneView()
}
