//
//  ProfileViewModel.swift
//  Profile
//
//  Created by root0 on 2/19/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import SwiftUI
import ProfileInterface
import ProfileDomainInterface
import Combine
import CoordinatorFeatureInterface

public class ProfileViewModel: ProfileInterface {

    private var profileUsecase: FetchMemberProfileUsecase
    private var coordinator: any CoordinatorNavigationInterface
    private var flowCoordinator: any ProfileFlowInterface

    public init(profileUsecase: FetchMemberProfileUsecase, coordinator: any CoordinatorNavigationInterface, flow: any ProfileFlowInterface) {
        self.profileUsecase = profileUsecase
        self.coordinator = coordinator
        self.flowCoordinator = flow
    }

    public func fetchMemberInfo() async -> Member {
        do {
            let member = try await profileUsecase.fetchMemberProfile()
            return member
        } catch {
            print(error.localizedDescription)
            return .default
        }
    }

    public func backToRoot() {
        coordinator.pop()
    }

    public func goChat(with member: Int) {
//        coordinator.push(.chatting)
        flowCoordinator.goChatFlow(with: member)
    }

    public func openWeb() {
        coordinator.push(.webView("alim"))
    }
}
