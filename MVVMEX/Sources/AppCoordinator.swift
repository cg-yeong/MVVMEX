//
//  AppCoordinator.swift
//  MVVMEX
//
//  Created by root0 on 2/24/25.
//

import SwiftUI
import BaseFeatureInterface
import BaseFeature
import CoordinatorFeatureInterface
import ProfileDomainInterface
import ProfileDomain
import ProfileInterface
import ProfileFeature
import ChattingInterface
import ChattingFeature
import MessageBoxInterface
import MessageBoxFeature

final class Coordinator: ObservableObject, CoordinatorInterface {

    @Published var path: [CoordinatorFeatureInterface.FeaturePages] = [] {
        didSet {
            print("========")
            print("Coordinator path: \(path.map({ $0.rawValue }))")
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

    init() {}

    func push(_ destination: CoordinatorFeatureInterface.FeaturePages) {
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
}

public struct CoordinatorModifier: ViewModifier {
    var coordinator: CoordinatorInterface
    var container: DIContainer

    init(_ coordinator: CoordinatorInterface, with container: DIContainer) {
        self.coordinator = coordinator
        self.container = container
    }

    public func body(content: Content) -> some View {
        content
            .navigationDestination(for: FeaturePages.self) { page in
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

