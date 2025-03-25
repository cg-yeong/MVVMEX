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
import ComposableArchitecture

public struct SUWebView: View {
    let store: StoreOf<FFWebViewStore>
    var coordinator: any BaseFlowInterface

    public init(store: StoreOf<FFWebViewStore>, coordinator: any BaseFlowInterface) {
        self.store = store
        self.coordinator = coordinator
    }

    public var body: some View {
        ZStack {
            FFWebView(store: store)
                .background(
                    Color.yellow.opacity(0.5)
                        .onTapGesture {
                            coordinator.goBackFlow()
                        }
                )
                .onAppear {
                    store.send(.onAppear)
                }

//            VStack {
//                Button {
//                    coordinator.goWebListFlow(page: "alim")
//                } label: {
//                    Text("GO Profile")
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(.blue.opacity(0.5))
//                        .clipShape(Capsule())
//                }
//                .padding(.horizontal, 12)
//
//                Button {
//                    coordinator.goMessageBoxFlow()
//                } label: {
//                    Text("GO MessageBox")
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(.blue.opacity(0.5))
//                        .clipShape(Capsule())
//                }
//                .padding(.horizontal, 12)
//            }
        }
    }

}
