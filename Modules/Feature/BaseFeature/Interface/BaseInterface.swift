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
    func openWebView(_ detail: String)
    func backToRoot()
    
    func fetchWebSetting() async
}

public protocol BaseFlowInterface {
    func getPathStack() -> [String]

    func goBackFlow()
    func goProfileFlow()
    func goMessageBoxFlow()
    func goChatFlow(with member: Int)
    func goWebListFlow(page: String)
}
