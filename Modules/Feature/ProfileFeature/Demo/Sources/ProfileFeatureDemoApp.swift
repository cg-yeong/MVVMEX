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

@main
struct DemoApp: SwiftUI.App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            let mockUsecase = MockMemberProfileUsecaseImpl()
            let mockVM = ProfileViewModel(profileUsecase: mockUsecase, flow: MockCoordinator())
            CircleThumbnail(viewModel: mockVM)
        }
    }
}

enum ProfilePage: Hashable, Codable {
    case profile
}

class MockCoordinator: ObservableObject, ProfileFlowInterface {

    init() {}

    public var path: [ProfilePage] = []

    func goChatFlow(with member: Int) {

    }

    func goWebListFlow(page: String) {

    }

    func goBackFlow() {

    }
}
