//
//  CoordinatorInterface.swift
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
    case webView
}

public protocol CoordinatorInterface: AnyObject {
    var path: [FeaturePages] { get }
    func push(_ destination: FeaturePages)
    func popToRoot()
    func pop()
    func remove(_ page: FeaturePages)
    func set(paths: [FeaturePages])
}

public protocol DependencyInjectable: AnyObject {
    associatedtype Container
    func getContainer() -> Container
}

public protocol RoutableInterface: AnyObject {
    var routePathPublisher: PassthroughSubject<FeaturePages, Never> { get }
}

public protocol RoutePathListener: AnyObject {
    func onReceivePath(_ page: FeaturePages)
}

