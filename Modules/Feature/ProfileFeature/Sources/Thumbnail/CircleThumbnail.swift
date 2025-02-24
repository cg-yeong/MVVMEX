//
//  UserCard.swift
//  MVVMEX
//
//  Created by root0 on 2/17/25.
//

import SwiftUI
import Combine
import CoordinatorFeatureInterface
import ProfileInterface
import ProfileDomainInterface

public struct CircleThumbnail<ViewModel: ProfileInterface>: View {
    @State private var member: Member = .default
    private var viewModel: ViewModel

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack {
            goBackAndWeb

            profileImage

            profileName

            goChat
        }
        .onAppear {
            Task { @MainActor in
                member = await viewModel.fetchMemberInfo()
            }
        }
    }

    @ViewBuilder
    var goBackAndWeb: some View {
        Button {
            viewModel.backToRoot()
        } label: {
            Text("GO BackBaek")
                .padding()
                .frame(maxWidth: .infinity)
                .background(.blue.opacity(0.5))
                .clipShape(Capsule())
        }
        .padding(.horizontal, 12)

        Button {
            viewModel.openWeb()
        } label: {
            Text("GO Web")
                .padding()
                .frame(maxWidth: .infinity)
                .background(.blue.opacity(0.5))
                .clipShape(Capsule())
        }
        .padding(.horizontal, 12)
    }

    @ViewBuilder
    var profileImage: some View {
        // [](https://randomuser.me/api/portraits/women/70.jpg)
        AsyncImage(url: URL(string: member.picture)) { image in
            image.resizable()
        } placeholder: {
            let wooeng = UIImage(named: "wooeng_demo")
            if wooeng != nil {
                Image(uiImage: wooeng!)
            } else {
                ProgressView()
            }
        }
        .frame(width: 240, height: 240)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.yellow, lineWidth: 6))
        .shadow(radius: 20, y: 1)
        .contentShape(Rectangle())
    }

    @ViewBuilder
    var profileName: some View {
        Text(member == .default ? " " : member.name)
            .font(.largeTitle)
    }

    @ViewBuilder
    var goChat: some View {
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
    }
}
