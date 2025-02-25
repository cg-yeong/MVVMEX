//
//  MMInterface.swift
//  MegaphoneInterface
//
//  Created by root0 on 2/25/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation

/// UI 와 관련된 Interface가 아닌 Logic 측면 Interface
public protocol MMSendable {}
public protocol MMInterface: MMSendable {

    // MARK: Usecase
    /// send to webServer
    func sendMM() async
    /// 구현체에서 Cash와 대상멤버, 기타 Parameter 검증한지
    func checkMMSendable() async
}

