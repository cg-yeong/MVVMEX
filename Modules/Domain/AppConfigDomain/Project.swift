//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/19/25.
//

@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers

//let profile: String = Module.Feature.Profile.rawValue
let appConfig = "AppConfigDomain"

let project = Project.module(
    name: "AppConfigDomain",
    targets: [
        .interface(module: "AppConfigDomainInterface"),
        .implements(module: appConfig, dependencies: [
            .project(target: "AppConfigDomainInterface", path: .relativeToDomain(appConfig)),
            .project(target: "NetworkingInterface", path: .relativeToCore("Networking"))
        ]),
        .testing(module: "AppConfigDomainTesting", dependencies: [
            .project(target: "AppConfigDomainInterface", path: .relativeToDomain(appConfig))
        ]),
        .tests(module: "AppConfigDomainTests", dependencies: [
            .project(target: appConfig, path: .relativeToDomain(appConfig))
        ])
    ]
)
