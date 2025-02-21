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

final public class Coordinator: ObservableObject, CoordinatorInterface, DependencyInjectable {

    public let container: DIContainer = .shared

    @Published public var path: [BaseFeatureInterface.FeaturePages] = [] {
        willSet {
            print("Coordinator path: \(path), \(newValue)")
        }
        didSet {
            print("Coordinator path: \(path)")
            print("========")
        }
    }

    public var bindingPath: Binding<[FeaturePages]> {
        Binding {
            self.path
        } set: { newPath in
            self.set(paths: newPath)
        }
    }

    public init() {
        start()
    }

    public func start() {
        // Profile
        container.register(MemberProfileRepository.self) {
            MemberProfileRepositoryImpl()
        }
        container.register(FetchMemberProfileUsecase.self) {
            FetchMemberProfileUsecaseImpl(profileRepository: self.container.resolve(MemberProfileRepository.self)!)
        }
        container.register(ProfileInterface.self) {
            ProfileViewModel(profileUsecase: self.container.resolve(FetchMemberProfileUsecase.self)!, coordinator: self)
        }

        // Message
        container.register(ChattingInterface.self) {
            ChattingViewModel(coordinator: self)
        }

        // MessageBox
        container.register(MessageBoxInterface.self) {
            MessageBoxViewModel(coordinator: self)
        }
    }

    public func push(_ destination: BaseFeatureInterface.FeaturePages) {
        path.append(destination)
    }

    public func popToRoot() {
        path.removeAll()
    }

    public func pop() {
        path.removeLast()
    }

    public func remove(_ page: FeaturePages) {
        path.removeAll(where: { $0 == page })
    }

    public func set(paths: [FeaturePages]) {
        path = paths
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
                    if let viewModel = coordinator.container.resolve((any ProfileInterface).self) as? ProfileViewModel {
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
