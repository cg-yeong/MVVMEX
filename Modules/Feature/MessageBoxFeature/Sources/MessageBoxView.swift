//
//  MessageBoxView.swift
//  MessageBoxFeature
//
//  Created by root0 on 2/21/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import SwiftUI
import BaseFeatureInterface
import MessageBoxInterface

public struct MessageBoxView: View {
    @ObservedObject private var viewModel: MessageBoxViewModel

    public init(viewModel: MessageBoxViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack {
            Button {
                viewModel.backToRoot()
            } label: {
                Text("GO BACK")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.blue.opacity(0.5))
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 12)

            Button {
                viewModel.goWeb()
            } label: {
                Text("GO Web")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.blue.opacity(0.5))
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 12)

            Button {
                viewModel.goChat(with: 0)
            } label: {
                Text("GO Chatting")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.blue.opacity(0.5))
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 12)

            Button {
                viewModel.presentMM()
            } label: {
                Text("GO MegaMega")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.blue.opacity(0.5))
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 12)
        }
        .fullScreenCover(isPresented: $viewModel.isPresentingMM) {
            Text("메가메가메가치킨마요")
                .background {
                    Color.green.frame(maxWidth: .infinity)
                }
                .onTapGesture {
                    viewModel.presentMM()
                }
        }
//        .modifier(MMOpenModifier(isPresented: $viewModel.isPresentingMM, boxViewModel: viewModel))
    }
}

