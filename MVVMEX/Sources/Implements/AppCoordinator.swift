//
//  AppCoordinator.swift
//  MVVMEX
//
//  Created by root0 on 2/24/25.
//

import SwiftUI
import BaseFeatureInterface
import BaseFeature
import ProfileDomainInterface
import ProfileDomain
import ProfileInterface
import ProfileFeature
import ChattingInterface
import ChattingFeature
import MessageBoxInterface
import MessageBoxFeature

/// MainFeature 에 있어야 하기 때문에 App 레이어에 있는 AppDelegate, SceneDelegate 모르게 구현해보자
final class Coordinator: ObservableObject, CoordinatorNavigationInterface {
    
    @Published var key: UUID = .init() {
        didSet {
            print("Coordinator ID Key: \(key)")
        }
    }
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

    func restartAppDelegateApp() {

        let anyAppDelegate = UIApplication.shared.delegate // -> SwiftUI.AppDelegate
        print("anyAppDelegate type: \(anyAppDelegate.self)")
        let apd = anyAppDelegate as? AppDelegate

        if let apd = apd {
//            apd.restart()
        } else {
            print("AppDelegate not found")
        }

        let scenes = UIApplication.shared.connectedScenes
        let wsc = scenes.first(where: { $0 is UIWindowScene })
        let sdelegate = wsc?.delegate
        let anySceneDelegate = wsc?.delegate // -> SwiftUI.AppSceneDelegate
        print("anySceneDelegate type: \(anySceneDelegate.self)")
        let sc = anySceneDelegate as? SceneDelegate
        if let sc = sc {
            sc.restart()
        } else {
            print("SceneDelegate 1 not found")
        }

    }

    func restartSwiftUIApp() {
        DispatchQueue.main.async {
            self.key = .init()
        }
    }
}

extension Coordinator: BaseFlowInterface, ProfileFlowInterface, ChattingFlowInterface, MessageBoxFlowInterface {

    func getPathStack() -> [String] {
        return path.map { $0.rawValue }
    }

    func goProfileFlow() {
        push(.profile)
    }

    func goMessageBoxFlow() {
        popToRoot()
        push(.messageBox)
    }

    func goWebListFlow(page: String) {
        if path.last == .webView("alim") {
            pop()
        } else {
            push(.webView(page))
        }
    }
    
    func goBackFlow() {
        pop()
    }
    
    func goChatFlow(with member: Int) {
        push(.chatting)
    }

    func goLogoutFlow() {
        popToRoot()
        restartSwiftUIApp()
        restartAppDelegateApp()
    }
}
