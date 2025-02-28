//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/19/25.
//

@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers

//let profile: String = Module.Feature.Profile.rawValue

let project = Project.module(
    name: <#module name#>,
    targets: [
        .interface(module: <#module name#>),
        .implements(module: <#module name#>, dependencies: [
            .project(target: <#module name interface#>, path: .relativeToFeature(<#module name#>))
        ]),
        .testing(module: <#module name testing#>, dependencies: [
            .project(target: <#module name interface#>, path: .relativeToFeature(<#module name#>))
        ]),
        .tests(module: <#module name tests#>, dependencies: [
            .project(target: <#module name#>, path: .relativeToFeature(<#module name#>))
        ]),
        .demo(module: <#module name demo#>, dependencies: [
            .project(target: <#module name#>, path: .relativeToFeature(<#module name#>))
        ])
    ]
)
