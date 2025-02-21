//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/19/25.
//

import Foundation
@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: "ProfileDomain",
    targets: [
        .interface(module: "ProfileDomainInterface", dependencies: [
            TargetDependency.SPM.SwiftyJSON
        ]),
        .implements(module: "ProfileDomain", dependencies: [
            .project(target: "ProfileDomainInterface", path: .relativeToDomain("ProfileDomain")),
            .project(target: "NetworkingInterface", path: .relativeToCore("Networking"))
        ]),
        .testing(module: "ProfileDomainTesting", dependencies: [
            .project(target: "ProfileDomainInterface", path: .relativeToDomain("ProfileDomain"))
        ]),
        .tests(module: "ProfileDomainTests", dependencies: [
            .project(target: "ProfileDomain", path: .relativeToDomain("ProfileDomain"))
        ])
    ]
)
