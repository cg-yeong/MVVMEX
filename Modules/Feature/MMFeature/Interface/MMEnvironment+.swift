//
//  MMEnvironment+.swift
//  MegaphoneInterface
//
//  Created by root0 on 2/25/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

/// MMFeature에서 사용할 환경변수 기본 property?
import Foundation
import Combine
import SwiftUI

public extension EnvironmentValues {

    /// For ViewModel - Presenter; Internal View Coordinator (Sub Coordinator)
    /// View.onTapGesture -> publish -> View Refresh -> View Change
    @Entry var megaCoordinator: PassthroughSubject<UUID, Never> = .init()

    /// ViewModel User Input Policy
    @Entry var megaMessageMaxLength: Int = 150
    @Entry var megafilterAgeDifference: Float = 5.0
}
