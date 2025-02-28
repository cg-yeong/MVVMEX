//
//  Interface.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/18/25.
//

import Foundation

public protocol MessageBoxInterface {
    func backToRoot()
    func goChat(with member: Int)
    func goWeb()
    func presentMM()
}

public protocol MessageBoxFlowInterface {
    func goChatFlow(with member: Int)
    func goWebListFlow(page: String)
    func goBackFlow()
}
