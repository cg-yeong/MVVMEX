//
//  CoordinatorModifier.swift
//  MVVMEX
//
//  Created by root0 on 2/25/25.
//

import Foundation
import SwiftUI
import Combine
import ProfileInterface
import ProfileFeature
import MessageBoxInterface
import MessageBoxFeature
import ChattingInterface
import ChattingFeature
import BaseFeatureInterface
import BaseFeature
import MegaphoneInterface
import MMFeature

public struct CoordinatorModifier: ViewModifier {
    var coordinator: CoordinatorInterface
    var container: DIContainer

    init(_ coordinator: CoordinatorInterface, with container: DIContainer) {
        self.coordinator = coordinator
        self.container = container
    }

    public func body(content: Content) -> some View {
        let container = AppDelegate.container
        content
            .navigationDestination(for: AppPages.self) { page in
                switch page {
                case .profile:
                    if let viewModel = AppDelegate.container.resolve(ProfileInterface.self) as? ProfileViewModel {
                        CircleThumbnail(viewModel: viewModel)
                            .navigationBarBackButtonHidden()
                            .navigationTitle("")
                            .navigationBarHidden(true)
                    } else {
                        fatalError()
                    }
                case .chatting:
                    if let viewModel = AppDelegate.container.resolve(ChattingInterface.self) as? ChattingViewModel {
                        ChattingWithOther(viewModel: viewModel)
                            .navigationBarBackButtonHidden()
                            .navigationTitle("")
                            .navigationBarHidden(true)
                    } else {
                        fatalError()
                    }
                case .messageBox:
                    if let viewModel = AppDelegate.container.resolve(MessageBoxInterface.self) as? MessageBoxViewModel {
                        MessageBoxView(viewModel: viewModel)
                            .navigationBarBackButtonHidden()
                            .navigationTitle("")
                            .navigationBarHidden(true)
                    } else {
                        fatalError()
                    }
                case .webView:
                    SUWebView(coordinator: coordinator)
                        .navigationBarBackButtonHidden()
                        .navigationTitle("")
                        .navigationBarHidden(true)
                default:
                    Color.blue.frame(width: 200, height: 200).opacity(0.5)
                }
            }
    }
}

