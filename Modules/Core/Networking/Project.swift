//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/19/25.
//

@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: "Networking",
    targets: [
        .interface(module: "NetworkingInterface"),
        .implements(module: "Networking", dependencies: [
            .project(target: "NetworkingInterface", path: .relativeToCore("Networking"))
        ])
    ]
)
