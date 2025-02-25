//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/19/25.
//

@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers

let box: String = Module.Feature.MessageBoxFeature.rawValue

let project = Project.module(
    name: box,
    targets: [
        .interface(module: "MessageBoxInterface"),
        .implements(module: "MessageBoxFeature", dependencies: [

            .project(target: "MessageBoxInterface", path: .relativeToFeature("MessageBoxFeature"))
        ]),
//        .testing(module: "MessageBoxTesting", dependencies: [
//            .project(target: "MessageBoxInterface", path: .relativeToFeature("MessageBox"))
//        ]),
//        .tests(module: "MessageBoxTests", dependencies: [
//            .project(target: "MessageBox", path: .relativeToFeature("MessageBox"))
//        ]),
        .demo(module: "MessageBoxDemo", dependencies: [
            .project(target: "MessageBoxFeature", path: .relativeToFeature("MessageBoxFeature"))
        ])
    ]
)
