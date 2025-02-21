//
//  FeatureDIContainer.swift
//  BaseFeature
//
//  Created by root0 on 2/21/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import BaseFeatureInterface
import ProfileFeature
import ProfileDomainInterface
import ProfileDomain
import ChattingFeature

public protocol DependencyInjectable: AnyObject {
    associatedtype Container
    func getContainer() -> Container
}

public class DIContainer {

    static let shared = DIContainer()

    private var services: [String: Any] = [:]

    public func register<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = String(describing: type)
        services[key] = factory
    }

    public func resolve<T>(_ type: T.Type) -> T? {
        let key = String(describing: type)
        guard let factory = services[key] as? () -> T else {
            return nil
        }
        return factory()
    }

    public func resolveProfileViewModel(coordinator: any CoordinatorInterface) -> ProfileViewModel {
        let repo = MemberProfileRepositoryImpl()
        let usecase = FetchMemberProfileUsecaseImpl(profileRepository: repo)
        let viewModel = ProfileViewModel(profileUsecase: usecase, coordinator: coordinator)

        return viewModel
    }
}
