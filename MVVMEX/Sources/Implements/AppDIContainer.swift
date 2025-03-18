//
//  AppDependenciesContainer.swift
//  MVVMEX
//
//  Created by root0 on 2/24/25.
//

import Foundation
import ProfileDomainInterface
import ProfileDomain
import AppConfigDomainInterface
import AppConfigDomain

import ProfileInterface
import ProfileFeature
import ChattingInterface
import ChattingFeature
import MessageBoxInterface
import MessageBoxFeature
import BaseFeatureInterface
import BaseFeature

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

        registerAppconfigDomain()
        registerProfileDomain()
        registerFeatures(flow: coordinator)

    }

    func makeBaseViewModel(coordinator: CoordinatorInterface) -> BaseViewModel {
        if let viewModel = resolve(BaseInterface.self) as? BaseViewModel {
            return viewModel
        } else {
            let repository = WebSettingRepositoryImpl()
            let usecase: FetchWebSettingUsecase = FetchWebSettingUsecaseImpl(webSettingRepository: repository)
            return BaseViewModel(flow: coordinator, webSettingUsecase: usecase)
        }
    }
}

extension DIContainer {
    func registerAppconfigDomain() {
        register(WebSettingRepository.self) {
            WebSettingRepositoryImpl()
        }

        register(FetchWebSettingUsecase.self) {
            FetchWebSettingUsecaseImpl(webSettingRepository: self.resolve(WebSettingRepository.self)!)
        }
    }

    func registerProfileDomain() {
        register(MemberProfileRepository.self) {
            MemberProfileRepositoryImpl()
        }
        register(FetchMemberProfileUsecase.self) {
            FetchMemberProfileUsecaseImpl(profileRepository: self.resolve(MemberProfileRepository.self)!)
        }
    }

    func registerFeatures(flow coordinator: CoordinatorInterface) {
        // Base
        register(BaseInterface.self) {
            BaseViewModel(flow: coordinator, webSettingUsecase: self.resolve(FetchWebSettingUsecase.self)!)
        }

        // Profile
        register(ProfileInterface.self) {
            ProfileViewModel(profileUsecase: self.resolve(FetchMemberProfileUsecase.self)!, flow: coordinator)
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
