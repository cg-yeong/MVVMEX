//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/19/25.
//

@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers

let chatting: String = Module.Feature.ChattingFeature.rawValue

let project = Project.module(
    name: chatting,
    targets: [
        .interface(module: "ChattingInterface", dependencies: [
            .project(target: "BaseFeatureInterface", path: .relativeToFeature("BaseFeature"))
        ]),
        .implements(module: "ChattingFeature", dependencies: [
            .project(target: "ChattingInterface", path: .relativeToFeature("ChattingFeature")),
        ]),
//        .testing(module: "ChattingTesting", dependencies: [
//            .project(target: "ChattingInterface", path: .relativeToFeature("Chatting"))
//        ]),
//        .tests(module: "ChattingTests", dependencies: [
//            .project(target: "Chatting", path: .relativeToFeature("Chatting"))
//        ]),
        .demo(module: "ChattingDemo", dependencies: [
            .project(target: "ChattingFeature", path: .relativeToFeature("ChattingFeature"))
        ])
    ]
)
