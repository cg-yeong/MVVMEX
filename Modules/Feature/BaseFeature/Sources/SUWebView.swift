//
//  SUWebView.swift
//  BaseFeature
//
//  Created by root0 on 2/20/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import SwiftUI
import Combine
import BaseFeatureInterface

public struct SUWebView: View {
    var coordinator: any BaseFlowInterface

    public init(coordinator: any BaseFlowInterface) {
        self.coordinator = coordinator
    }

    public var body: some View {
        Color.red.opacity(0.5)
            .overlay {
                VStack {
                    Button {
                        coordinator.goWebListFlow(page: "alim")
                    } label: {
                        Text("GO Profile")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.blue.opacity(0.5))
                            .clipShape(Capsule())
                    }
                    .padding(.horizontal, 12)

                    Button {
                        coordinator.goMessageBoxFlow()
                    } label: {
                        Text("GO MessageBox")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.blue.opacity(0.5))
                            .clipShape(Capsule())
                    }
                    .padding(.horizontal, 12)
                }
            }
            .onTapGesture {
                coordinator.goBackFlow()
            }
    }

}
