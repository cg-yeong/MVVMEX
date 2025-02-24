//
//  FeatureDIContainer.swift
//  BaseFeature
//
//  Created by root0 on 2/21/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import BaseFeatureInterface

import ProfileDomainInterface
import ProfileDomain
import ProfileInterface
import ProfileFeature
import ChattingInterface
import ChattingFeature
import MessageBoxInterface
import MessageBoxFeature

protocol DependencyInjectable: AnyObject {
    associatedtype Container
    var container: Container { get }
}

class DIContainer {

    static let shared = DIContainer()

    private init() {}

    private var services: [String: Any] = [:]

    func register<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = String(describing: type)
        services[key] = factory
    }

    func resolve<T>(_ type: T.Type) -> T? {
        let key = String(describing: type)
        guard let factory = services[key] as? () -> T else {
            print("\(type): DI Container에 미등록")
            return nil
        }
        return factory()
    }

    func start(with coordinator: CoordinatorInterface) {
        register(MemberProfileRepository.self) {
            MemberProfileRepositoryImpl()
        }
        register(FetchMemberProfileUsecase.self) {
            FetchMemberProfileUsecaseImpl(profileRepository: self.resolve(MemberProfileRepository.self)!)
        }
        register(ProfileInterface.self) {
            ProfileViewModel(profileUsecase: self.resolve(FetchMemberProfileUsecase.self)!, coordinator: coordinator)
        }

        // Message
        register(ChattingInterface.self) {
            ChattingViewModel(coordinator: coordinator)
        }

        // MessageBox
        register(MessageBoxInterface.self) {
            MessageBoxViewModel(coordinator: coordinator)
        }
    }
}
