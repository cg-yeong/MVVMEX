//
//  FeatureSelectView.swift
//  BaseFeature
//
//  Created by root0 on 2/19/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import SwiftUI

public struct FeatureSelectView: View {
    public init() {}
    public var body: some View {
        VStack {
            Button {
                // coordinator.open profile
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
    }
}

#Preview {
    FeatureSelectView()
}
