//
//  Sources.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/18/25.
//

import Foundation
import SwiftUI
import CoordinatorFeatureInterface
import ChattingInterface

public struct ChattingWithOther<ViewModel: ChattingInterface>: View {

    private var viewModel: ViewModel

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    public var body: some View {
        Button {
            viewModel.back()
        } label: {
            Text("ChattingView; go back")
                .padding()
                .frame(maxWidth: .infinity)
                .background(.blue.opacity(0.5))
                .clipShape(Capsule())
        }
        .padding(.horizontal, 12)

        Button {
            viewModel.back()
        } label: {
            Text("ChattingView; go back")
                .padding()
                .frame(maxWidth: .infinity)
                .background(.blue.opacity(0.5))
                .clipShape(Capsule())
        }
        .padding(.horizontal, 12)

    }
}
