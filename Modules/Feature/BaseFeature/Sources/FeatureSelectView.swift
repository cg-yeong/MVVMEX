//
//  FeatureSelectView.swift
//  BaseFeature
//
//  Created by root0 on 2/19/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import SwiftUI
import BaseFeatureInterface

public struct FeatureSelectView: View {

    var coordinator: CoordinatorInterface = Coordinator()

    public init() {

    }

    var bindingPath: Binding<[FeaturePages]> {
        Binding {
            coordinator.path
        } set: { newPath in
            coordinator.set(paths: newPath)
        }
    }


    public var body: some View {
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

        NavigationStack(path: bindingPath) {

        }
        .navigationDestination(for: FeaturePages.self) { page in
            switch page {
            case .profile:
                CircleThumbnail()
            case .messageBox:
                Text("MessageBox")
            case .chatting:
                Text("Chatting")
            case .webView:
                SUWebView()
            default:
                EmptyView().hidden()
            }
        }

    }
}

#Preview {
    FeatureSelectView()
}
