//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/18/25.
//

@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: "BaseFeature",
    targets: [
        .interface(module: "BaseFeatureInterface"),
        .implements(module: "BaseFeature", dependencies: [
            .project(target: "BaseFeatureInterface", path: .relativeToFeature("BaseFeature")),
        ])
    ]
)
