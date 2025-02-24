//
//  SUWebView.swift
//  BaseFeature
//
//  Created by root0 on 2/20/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import SwiftUI
import CoordinatorFeatureInterface
import Combine

public struct SUWebView: View {
    var coordinator: any CoordinatorInterface

    public init(coordinator: any CoordinatorInterface) {
        self.coordinator = coordinator
    }

    public var body: some View {
        Color.red.opacity(0.5)
            .overlay {
                VStack {
                    Button {
                        if coordinator.path.last == .webView("alim") {
                            coordinator.pop()
                        } else {
                            coordinator.push(.profile)
                        }
                    } label: {
                        Text("GO Profile")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.blue.opacity(0.5))
                            .clipShape(Capsule())
                    }
                    .padding(.horizontal, 12)

                    Button {
                        coordinator.popToRoot()
                        coordinator.push(.messageBox)
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
                coordinator.pop()
            }
    }

}
