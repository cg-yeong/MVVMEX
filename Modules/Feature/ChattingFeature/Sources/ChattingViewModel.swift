//
//  ChattingViewModel.swift
//  ChattingFeature
//
//  Created by root0 on 2/21/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import ChattingInterface
import CoordinatorFeatureInterface

public class ChattingViewModel: ChattingInterface {

//    private var chattingUsecase:
    private var coordinator: any CoordinatorNavigationInterface

    public init(coordinator: any CoordinatorNavigationInterface) {
        self.coordinator = coordinator
    }

    public func back() {
        coordinator.pop()
    }
}
