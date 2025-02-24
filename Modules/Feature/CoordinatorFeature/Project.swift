//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/20/25.
//

@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: "CoordinatorFeature",
    targets: [
        .interface(module: "CoordinatorFeatureInterface", dependencies: [
        ]),
        .implements(module: "CoordinatorFeature", dependencies: [
            .project(target: "CoordinatorFeatureInterface", path: .relativeToFeature("CoordinatorFeature")),
//            .project(target: "ProfileInterface", path: .relativeToFeature("ProfileFeature")),
//            .project(target: "MessageBoxInterface", path: .relativeToFeature("MessageBoxFeature")),
//            .project(target: "ChattingInterface", path: .relativeToFeature("ChattingFeature")),
        ])
    ]
)
