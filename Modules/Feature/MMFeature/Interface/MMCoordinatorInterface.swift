//
//  MMCoordinatorInterface.swift
//  MegaphoneInterface
//
//  Created by root0 on 2/25/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation

public struct MMScene: OptionSet {
    public var rawValue: Int

    public static var none: Self = .init(rawValue: 1 << 0)         // 1
    public static var filter: Self = .init(rawValue: 1 << 1)       // 2
    public static var send: Self = .init(rawValue: 1 << 2)         // 4
    public static var confirm: Self = .init(rawValue: 1 << 3)      // 8
    public static var complete: Self = .init(rawValue: 1 << 4)     // 16
    public static var notification: Self = .init(rawValue: 1 << 5) // 32

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

/// MM 내부 화면 전환 Coordinaor Interface?
/// MM Scene에 접근하기 위한 액션?
public protocol MMCoordinatorInterface: ObservableObject {
    var sceneOptionStore: MMScene { get }

    func onAppear()
    func present(from scene: MMScene)
    func dismiss(from scene: MMScene)
}
