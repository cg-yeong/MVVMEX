//
//  BaseToast.swift
//  BaseFeature
//
//  Created by root0 on 3/27/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import SwiftUI
import BaseFeatureInterface

public enum ToastPosition {
    case top
    case center
    case bottom
}

public struct BaseToast: View {

    private(set) var message: String
    private(set) var duration: Double = 3.0
    private(set) var position: ToastPosition = .center

    public init(message: String = "") {
        self.message = message.isEmpty ? "Toast Window" : message
    }
    public var body: some View {
        switch position {
        case .top:
            VStack {
                contents
                Spacer()
            }
        case .center:
            VStack {
                contents
            }
        case .bottom:
            VStack {
                Spacer()
                contents
            }
        }
    }

    @ViewBuilder
    public var contents: some View {
        Text(message)
            .foregroundStyle(.white)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(.black)
            )
    }
}

public struct BaseToastViewModel {

    private var coordinator: any ToastInterface

    public init(coordinator: any ToastInterface) {
        self.coordinator = coordinator
    }



}
