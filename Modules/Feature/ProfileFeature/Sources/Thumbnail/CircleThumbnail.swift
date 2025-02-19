//
//  UserCard.swift
//  MVVMEX
//
//  Created by root0 on 2/17/25.
//

import SwiftUI

public struct CircleThumbnail: View {
    public init() {}

    public var body: some View {

        VStack {
            profileImage
        }
    }

    @ViewBuilder
    var profileImage: some View {
        AsyncImage(url: URL(string: "https://randomuser.me/api/portraits/women/70.jpg")) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 240, height: 240)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.yellow, lineWidth: 6))
        .shadow(radius: 20, y: 1)
    }
}

#Preview {
    CircleThumbnail()
}
