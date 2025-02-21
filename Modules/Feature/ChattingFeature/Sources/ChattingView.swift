//
//  Sources.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/18/25.
//

import Foundation
import SwiftUI
import BaseFeatureInterface
//import ProfileInterface
//import ProfileDomainInterface
import ChattingInterface

public struct ChattingWithOther<ViewModel: ChattingInterface>: View {
    
    private var viewModel: ViewModel

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    public var body: some View {
        Button {
            viewModel.backToRoot()
        } label: {
            Text("ChattingView")
                .padding()
                .frame(maxWidth: .infinity)
                .background(.blue.opacity(0.5))
                .clipShape(Capsule())
        }
        .padding(.horizontal, 12)

    }
}
