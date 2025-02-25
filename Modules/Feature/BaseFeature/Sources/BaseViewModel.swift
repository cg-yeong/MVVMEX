//
//  BaseViewModel.swift
//  BaseFeature
//
//  Created by root0 on 2/24/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import SwiftUI
import BaseFeatureInterface
import CoordinatorFeatureInterface

// path , push
public class BaseViewModel: BaseInterface {
    
    private var coordinator: any BaseFlowInterface

    public var coordinatorPath: [String] {
        return coordinator.getPathStack()
    }


    public init(coordinator: any BaseFlowInterface) {
        self.coordinator = coordinator
    }

    public func openProfile() {
        coordinator.openProfile()
    }

    public func openMessageBox() {
        coordinator.openMessageBox()
    }

    public func openChatting() {
        coordinator.openChatting()
    }

}
