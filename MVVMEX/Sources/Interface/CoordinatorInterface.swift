//
//  CoordinatorInterface.swift
//  MVVMEX
//
//  Created by root0 on 2/25/25.
//

import Foundation
import SwiftUI
import Combine

import BaseFeatureInterface
import BaseFeature
import ProfileDomainInterface
import ProfileDomain
import ProfileInterface
import ProfileFeature
import ChattingInterface
import ChattingFeature
import MessageBoxInterface
import MessageBoxFeature

public enum AppPages: Hashable, Codable {
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

public enum ModalPages: Hashable, Codable {
    case megamega
}

public protocol CoordinatorNavigationInterface: AnyObject {
    var path: [AppPages] { get }
    func push(_ destination: AppPages)
    func popToRoot()
    func pop()
    func remove(_ page: AppPages)
    func set(paths: [AppPages])
}

public typealias CoordinatorInterface = CoordinatorNavigationInterface & ProfileFlowInterface & ChattingFlowInterface & MessageBoxFlowInterface & BaseFlowInterface
