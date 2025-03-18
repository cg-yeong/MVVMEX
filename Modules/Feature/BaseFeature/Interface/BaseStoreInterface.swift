//
//  BaseStoreInterface.swift
//  BaseFeatureInterface
//
//  Created by root0 on 3/18/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import SwiftUI

public protocol StoreProtocol: ObservableObject {
    associatedtype State
    associatedtype Action

    func action(_ action: Action) async
}
