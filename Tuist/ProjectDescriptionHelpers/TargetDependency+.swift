//
//  TargetDependency+.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/18/25.
//

@preconcurrency import ProjectDescription

public extension TargetDependency {
    struct SPM {}
}

public extension TargetDependency.SPM {
    static let SwiftyJSON = TargetDependency.external(name: "SwiftyJSON")
}
