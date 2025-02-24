//
//  Coordinator.swift
//  BaseFeatureInterface
//
//  Created by root0 on 2/20/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import SwiftUI
import BaseFeatureInterface
import ProfileDomainInterface
import ProfileDomain
import ProfileInterface
import ProfileFeature
import ChattingInterface
import ChattingFeature
import MessageBoxInterface
import MessageBoxFeature

final class Coordinator: ObservableObject, CoordinatorInterface, DependencyInjectable {

    let container: DIContainer = .shared

    @Published var path: [BaseFeatureInterface.FeaturePages] = [] {
        didSet {
            print("========")
            print("Coordinator path: \(path)")
            print("========")
        }
    }

    var bindingPath: Binding<[FeaturePages]> {
        Binding {
            self.path
        } set: { newPath in
            self.set(paths: newPath)
        }
    }

    init() {
        container.start(with: self)
    }

    func push(_ destination: BaseFeatureInterface.FeaturePages) {
        path.append(destination)
    }

    func popToRoot() {
        path.removeAll()
    }

    func pop() {
        path.removeLast()
    }

    func remove(_ page: FeaturePages) {
        path.removeAll(where: { $0 == page })
    }

    func set(paths: [FeaturePages]) {
        path = paths
    }

    func resolveImplement<T, R>(_ type: T.Type, to: R.Type) -> R? {
        guard let factory = container.resolve(type) else {
            return nil
        }

        guard let implement = factory as? R else {
            return nil
        }
        return implement
    }
}

public struct CoordinatorModifier: ViewModifier {
    var coordinator: Coordinator

    init(_ coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    public func body(content: Content) -> some View {
        content
            .navigationDestination(for: FeaturePages.self) { page in
                switch page {
                case .profile:
                    if let viewModel = coordinator.container.resolve(ProfileInterface.self) as? ProfileViewModel {
                        CircleThumbnail(viewModel: viewModel)
                            .navigationBarBackButtonHidden()
                            .navigationTitle("")
                            .navigationBarHidden(true)
                    } else {
                        fatalError()
                    }
                case .chatting:
                    if let viewModel = coordinator.container.resolve(ChattingInterface.self) as? ChattingViewModel {
                        ChattingWithOther(viewModel: viewModel)
                            .navigationBarBackButtonHidden()
                            .navigationTitle("")
                            .navigationBarHidden(true)
                    } else {
                        fatalError()
                    }
                case .messageBox:
                    if let viewModel = coordinator.container.resolve(MessageBoxInterface.self) as? MessageBoxViewModel {
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
