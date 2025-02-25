//
//  Sources.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/18/25.
//

import Foundation
import MegaphoneInterface
import Combine
import SwiftUI

class MMCoordinator: ObservableObject, MMCoordinatorInterface {
    var sceneOptionStore: MegaphoneInterface.MMScene = .none

    init() {
        print(#function)
    }

    func onAppear() {
        insert(scene: .filter)
    }
    
    func present(from scene: MegaphoneInterface.MMScene) {
        switch scene {
        case .filter, .send:
            insert(scene: MMScene(rawValue: scene.rawValue << 1))
        case .confirm:
            sceneOptionStore = .complete
        case .complete:
            removeAllScene()
        case .notification:
            insert(scene: MMScene(rawValue: scene.rawValue))
        default:
            removeAllScene()
            break
        }
    }
    
    func dismiss(from scene: MegaphoneInterface.MMScene) {
        remove(scene: scene)
    }

    /// MMScene의 OptionsSet으로 현재 나와있는 Scene은 가장 큰 Option값
    private func isContains(scene: MMScene) -> Bool {
        sceneOptionStore.contains(scene)
    }

    private func insert(scene: MMScene) {
        withAnimation {
            sceneOptionStore = sceneOptionStore.union(scene)
        }
    }

    private func remove(scene: MMScene) {
        withAnimation {
            sceneOptionStore = sceneOptionStore.subtracting(scene)
        }
    }

    private func removeAllScene() {
        withAnimation {
            sceneOptionStore = .none
        }
    }

    deinit {
        print(#function)
    }
}
