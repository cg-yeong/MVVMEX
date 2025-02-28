//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/19/25.
//

@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers

let megaphone: String = Module.Feature.MegaphoneFeature.rawValue

let project = Project.module(
    name: megaphone,
    targets: [
        .interface(module: "MegaphoneInterface"),
        .implements(module: megaphone, dependencies: [
            .project(target: "MegaphoneInterface", path: .relativeToFeature(megaphone)),
            .project(target: "AppConfigDomainInterface", path: .relativeToDomain("AppConfigDomain"))
        ]),
        .testing(module: "MegaphoneTesting", dependencies: [
            .project(target: "MegaphoneInterface", path: .relativeToFeature(megaphone)),
            .project(target: "AppConfigDomainInterface", path: .relativeToDomain("AppConfigDomain"))
        ]),
        .tests(module: "MegaphoneTests", dependencies: [
            .project(target: megaphone, path: .relativeToFeature(megaphone)),
            .project(target: "MegaphoneTesting", path: .relativeToFeature(megaphone)),
            .project(target: "AppConfigDomainInterface", path: .relativeToDomain("AppConfigDomain"))
        ]),
        .demo(module: "MegaphoneDemo", dependencies: [
            .project(target: megaphone, path: .relativeToFeature(megaphone)),
            .project(target: "AppConfigDomainInterface", path: .relativeToDomain("AppConfigDomain"))
        ])
    ]
)
