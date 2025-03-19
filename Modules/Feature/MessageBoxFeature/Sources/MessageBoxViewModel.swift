//
//  Sources.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/18/25.
//

import Foundation
import SwiftUI
import MessageBoxInterface

public class MessageBoxViewModel: MessageBoxInterface, ObservableObject {
    @Published var isPresentingMM: Bool = false
//    @StateObject var 
    private var flowCoordinator: any MessageBoxFlowInterface

    public init(coordinator: any MessageBoxFlowInterface) {
        self.flowCoordinator = coordinator
    }

    public func backToRoot() {
        flowCoordinator.goBackFlow()
    }

    public func goChat(with member: Int) {
        flowCoordinator.goChatFlow(with: member)
    }

    public func goWeb() {
        flowCoordinator.goWebListFlow(page: "newList")
    }

    public func presentMM() {
        print("Modal MegaMega")
        self.isPresentingMM.toggle()
    }
}
