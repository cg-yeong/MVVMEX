//
//  BridgeResponseCMD.swift
//  WebServiceInterface
//
//  Created by root0 on 3/26/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum BridgeResponseCMD: String, CaseIterable {
    case aLogin
    case sLogin
    case fWin
    case oWin
    case getAdId
}

public protocol BridgeResponseDelegate: AnyObject {
    typealias BridgeCallback = (Any?) -> Void
    func aLogin(message: JSON, _ callback: BridgeCallback)
    func sLogin(message: JSON, _ callback: BridgeCallback)
    func fWin(message: JSON, _ callback: BridgeCallback)
    func oWin(message: JSON, _ callback: BridgeCallback)
    func getAdId(message: JSON, _ callback: BridgeCallback)
}
extension BridgeResponseDelegate {
    public func aLogin(message: JSON, _ callback: BridgeCallback) {}
    public func sLogin(message: JSON, _ callback: BridgeCallback) {}
    public func fWin(message: JSON, _ callback: BridgeCallback) {}
    public func oWin(message: JSON, _ callback: BridgeCallback) {}
//    public func getAdId(message: JSON, _ callback: BridgeCallback) {}
}
