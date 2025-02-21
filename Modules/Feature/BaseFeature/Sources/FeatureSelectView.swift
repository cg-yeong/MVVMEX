//
//  FeatureSelectView.swift
//  BaseFeature
//
//  Created by root0 on 2/19/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import SwiftUI
import BaseFeatureInterface
import ProfileFeature

import MessageBoxFeature
import ChattingFeature

public struct FeatureSelectView: View {

    @StateObject var coordinator: Coordinator = Coordinator()

    public init() {}

    public var body: some View {
        Text(coordinator.path.map { $0.rawValue }.joined())

        NavigationStack(path: coordinator.bindingPath) {
            VStack {
                Button {
                    // coordinator.open profile
                    coordinator.push(.profile)
                    print("Coordinator open Profile Feature")
                } label: {
                    Text("Profile")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 80)
                        .background(.yellow)
                        .clipShape(Capsule())
                }
                .padding(.horizontal, 12)

                Button {
                    // coordinator.open profile
                    coordinator.push(.messageBox)
                    print("Coordinator open MessageBox Feature")
                } label: {
                    Text("MessageBox")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 80)
                        .background(.yellow)
                        .clipShape(Capsule())
                }
                .padding(.horizontal, 12)

                Button {
                    // coordinator.open profile
                    coordinator.push(.chatting)
                    print("Coordinator open Chatting Feature")
                } label: {
                    Text("Chatting")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 80)
                        .background(.yellow)
                        .clipShape(Capsule())
                }
                .padding(.horizontal, 12)
            }
            .modifier(CoordinatorModifier(coordinator))
        }
    }
}

#Preview {
    FeatureSelectView()
}
