//
//  Sources.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/18/25.
//

import Foundation
import MessageBoxInterface
import CoordinatorFeatureInterface

public class MessageBoxViewModel: MessageBoxInterface {
    private var coordinator: any CoordinatorNavigationInterface

    public init(coordinator: any CoordinatorNavigationInterface) {
        self.coordinator = coordinator
    }

    public func backToRoot() {
        coordinator.pop()
    }

    public func goChat(with member: Int) {
        coordinator.push(.chatting)
    }

    public func goWeb() {
        coordinator.push(.webView("newList"))
    }
}
