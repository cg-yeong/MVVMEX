//
//  Scripts.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/18/25.
//

import Foundation
@preconcurrency import ProjectDescription

public extension TargetScript {
    static let swiftLint: TargetScript = .pre(
        path: .relativeToRoot("Scripts/RunSwiftLint.sh"),
        name: "SwiftLintShell",
        basedOnDependencyAnalysis: false
    )
}
