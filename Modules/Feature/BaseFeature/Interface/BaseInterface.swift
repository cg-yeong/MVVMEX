//
//  Interface.swift
//  BaseFeatureInterface
//
//  Created by root0 on 2/24/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import CoordinatorFeatureInterface

public protocol BaseInterface {
    var coordinatorPath: [FeaturePages] { get }
    func push(to path: FeaturePages)
}
