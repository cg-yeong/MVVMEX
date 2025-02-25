//
//  AppCoordinator.swift
//  MVVMEX
//
//  Created by root0 on 2/24/25.
//

import SwiftUI
import BaseFeatureInterface
import BaseFeature
import CoordinatorFeatureInterface
import ProfileDomainInterface
import ProfileDomain
import ProfileInterface
import ProfileFeature
import ChattingInterface
import ChattingFeature
import MessageBoxInterface
import MessageBoxFeature

public typealias CoordinatorInterface = CoordinatorNavigationInterface & ProfileFlowInterface

final class Coordinator: ObservableObject, CoordinatorNavigationInterface {

    @Published var path: [AppPages] = [] {
        didSet {
            print("========")
            print("Coordinator path: \(path.map({ $0.rawValue }))")
            print("========")
        }
    }

    var bindingPath: Binding<[AppPages]> {
        Binding {
            self.path
        } set: { newPath in
            self.set(paths: newPath)
        }
    }

    init() {}

    func push(_ destination: AppPages) {
        path.append(destination)
    }

    func popToRoot() {
        path.removeAll()
    }

    func pop() {
        path.removeLast()
    }

    func remove(_ page: AppPages) {
        path.removeAll(where: { $0 == page })
    }

    func set(paths: [AppPages]) {
        path = paths
    }
}
extension Coordinator: BaseFlowInterface {
    func getPathStack() -> [String] {
        return path.map { $0.rawValue }
    }
    
    func openProfile() {
        push(.profile)
    }
    
    func openMessageBox() {
        push(.messageBox)
    }
    
    func openChatting() {
        push(.chatting)
    }
}

extension Coordinator: ProfileFlowInterface, ChattingFlowInterface, MessageBoxFlowInterface {
    func goWebListFlow(page: String) {
        push(.webView(page))
    }
    
    func goBackFlow() {
        pop()
    }
    
    func goChatFlow(with member: Int) {
        push(.chatting)
    }
}
