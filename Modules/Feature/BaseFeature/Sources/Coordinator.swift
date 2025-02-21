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

final public class Coordinator: ObservableObject, CoordinatorInterface, DependencyInjectable {
    public func getContainer() -> DIContainer {
        return container
    }

    let container: DIContainer = DIContainer()

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
        container.register(MemberProfileRepository.self) {
            MemberProfileRepositoryImpl()
        }
        container.register(FetchMemberProfileUsecase.self) {
            FetchMemberProfileUsecaseImpl(profileRepository: self.container.resolve(MemberProfileRepository.self)!)
        }
        container.register(ProfileInterface.self) {
            ProfileViewModel(profileUsecase: self.container.resolve(FetchMemberProfileUsecase.self)!, coordinator: self)
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
                    let viewModel = coordinator.container.resolveProfileViewModel(coordinator: coordinator)
                    CircleThumbnail(viewModel: viewModel)
                case .messageBox:
                    Text("message box")
                case .chatting:
                    Text("Chatting")
                default:
                    Color.blue.frame(width: 200, height: 200).opacity(0.5)
                }
            }
    }
}
