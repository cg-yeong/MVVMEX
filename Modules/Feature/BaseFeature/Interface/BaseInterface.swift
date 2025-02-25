//
//  Interface.swift
//  BaseFeatureInterface
//
//  Created by root0 on 2/24/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation

public protocol BaseInterface {
    var coordinatorPath: [String] { get }

    func openProfile()
    func openMessageBox()
    func openChatting()
}

public protocol BaseFlowInterface {
    
    func getPathStack() -> [String]

    func openProfile()
    func openMessageBox()
    func openChatting()
}
