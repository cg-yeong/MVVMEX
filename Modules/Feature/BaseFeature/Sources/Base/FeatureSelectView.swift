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

            YSWebView(url: URL(string: "https://www.naver.com")!)
                .background(.blue)
                .frame(width: 300, height: 300)

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
                // coordinator.open profile
                viewModel.openWebView("web")
                print("Coordinator open Web Feature")
            } label: {
                Text("Web")
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
