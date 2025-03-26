//
//  DependencyValues+.swift
//  BaseFeature
//
//  Created by root0 on 3/24/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import ComposableArchitecture
import WebServiceInterface
import WebService

struct JSBridgeServiceDependency {
    static var liveValue: JavascriptBridgeService = JavascriptBridgeService()
}
//extension DependencyValues {
//    var javascriptBridgeService: JavascriptBridgeService {
//        get { self[JavascriptBridgeService.self] }
//        set { self[JavascriptBridgeService.self] = newValue }
//    }
//}
