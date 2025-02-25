//
//  CoordinatorNavigationInterface.swift
//  BaseFeatureInterface
//
//  Created by root0 on 2/20/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

public enum FeaturePages: Hashable, Codable {
//    case root
    case profile
    case messageBox
    case chatting
    case webView(String)

    public var rawValue: String {
        switch self {
        case .profile:
            "> profile"
        case .messageBox:
            "> messageBox"
        case .chatting:
            "> chatting"
        case .webView(let detail):
            "> webview_\(detail)"
        }
    }
}

public protocol CoordinatorNavigationInterface: AnyObject {
    var path: [FeaturePages] { get }
    func push(_ destination: FeaturePages)
    func popToRoot()
    func pop()
    func remove(_ page: FeaturePages)
    func set(paths: [FeaturePages])
}
