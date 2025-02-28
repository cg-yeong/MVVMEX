//
//  MMCoordinatorModifier.swift
//  MMFeature
//
//  Created by root0 on 2/28/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import MegaphoneInterface

struct MMCoordinatorModifier: ViewModifier {
    var mmCoordinator: any MMCoordinatorInterface

    init(mmCoordinator: any MMCoordinatorInterface) {
        self.mmCoordinator = mmCoordinator
    }
    func body(content: Content) -> some View {
        content
    }
}
