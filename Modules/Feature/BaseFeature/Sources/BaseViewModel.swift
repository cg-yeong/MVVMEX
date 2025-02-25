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
    private var coordinator: any CoordinatorNavigationInterface

    public var coordinatorPath: [FeaturePages] {
        return coordinator.path
    }


    public init(coordinator: any CoordinatorNavigationInterface) {
        self.coordinator = coordinator
    }

    public func push(to path: FeaturePages) {
        coordinator.push(path)
    }
}
