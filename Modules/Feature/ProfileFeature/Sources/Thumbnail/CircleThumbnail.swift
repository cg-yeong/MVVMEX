//
//  UserCard.swift
//  MVVMEX
//
//  Created by root0 on 2/17/25.
//

import SwiftUI
import Combine
import BaseFeatureInterface
import ProfileInterface
import ProfileDomainInterface

public struct CircleThumbnail<ViewModel: ProfileInterface>: View {

    private var viewModel: ViewModel

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack {
            profileImage
        }
        .onAppear {

        }
    }


    @ViewBuilder
    var profileImage: some View {
        // [](https://randomuser.me/api/portraits/women/70.jpg)
        AsyncImage(url: URL(string: "https://randomuser.me/api/portraits/women/70.jpg")) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 240, height: 240)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.yellow, lineWidth: 6))
        .shadow(radius: 20, y: 1)
        .onTapGesture {
            viewModel.backToRoot()
        }
    }
}
