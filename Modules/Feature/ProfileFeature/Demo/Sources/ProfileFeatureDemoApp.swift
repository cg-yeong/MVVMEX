//
//  ProfileFeatureDemoApp.swift
//  ProfileDemo
//
//  Created by root0 on 2/19/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import SwiftUI
import ProfileInterface
import ProfileDomainTesting
import ProfileTesting
import ProfileFeature

import BaseFeatureInterface

@main
struct DemoApp: SwiftUI.App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            let mockUsecase = MockMemberProfileUsecaseImpl()
            let mockVM = ProfileViewModel(profileUsecase: mockUsecase, coordinator: MockCoordinator())
            CircleThumbnail(viewModel: mockVM)
        }
    }
}

class MockCoordinator: ObservableObject, CoordinatorInterface {
    init() {}

    public var path: [BaseFeatureInterface.FeaturePages] = []

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
