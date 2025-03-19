//
//  FeatureSelectView.swift
//  BaseFeature
//
//  Created by root0 on 2/19/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import SwiftUI
import BaseFeatureInterface
import AppConfigDomainInterface

public struct FeatureSelectView<ViewModel: BaseInterface>: View {

//    @StateObject var coordinator: Coordinator = Coordinator()
    private var viewModel: ViewModel
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        Text(viewModel.coordinatorPath.compactMap({ $0 }).joined())

        VStack {
            Button {
                viewModel.openProfile()
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
                viewModel.openMessageBox()
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
                viewModel.openProfile()
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
