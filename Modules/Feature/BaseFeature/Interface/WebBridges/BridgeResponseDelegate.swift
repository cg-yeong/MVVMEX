//
//  ResponseBridgeDelegate.swift
//  BaseFeatureInterface
//
//  Created by root0 on 3/24/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum BridgeResponseCMD: String, CaseIterable {
    case aLogin
    case sLogin
    case fWin
    case oWin
}

public protocol BridgeResponseDelegate: AnyObject {
    func aLogin(message: JSON)
    func sLogin(message: JSON)
    func fWin(message: JSON)
    func oWin(message: JSON)
}
extension BridgeResponseDelegate {
    public func aLogin(message: JSON) {}
    public func sLogin(message: JSON) {}
    public func fWin(message: JSON) {}
    public func oWin(message: JSON) {}
}
