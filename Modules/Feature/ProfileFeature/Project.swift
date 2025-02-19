//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/18/25.
//

@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers

let profile: String = Module.Feature.ProfileFeature.rawValue

let project = Project.module(
    name: profile,
    targets: [
        .interface(module: "ProfileInterface", dependencies: [
            .project(target: "BaseFeatureInterface", path: .relativeToFeature("BaseFeature"))
        ]),
        .implements(module: "ProfileFeature", dependencies: [
            .project(target: "BaseFeature", path: .relativeToFeature("BaseFeature")),

            .project(target: "ProfileInterface", path: .relativeToFeature("ProfileFeature")),

            .project(target: "ProfileDomainInterface", path: .relativeToDomain("ProfileDomain"))
        ]),
        .testing(module: "ProfileTesting", dependencies: [
            .project(target: "ProfileInterface", path: .relativeToFeature("ProfileFeature")),

            .project(target: "ProfileDomainInterface", path: .relativeToDomain("ProfileDomain"))
        ]),
        .tests(module: "ProfileTests", dependencies: [
            .project(target: profile, path: .relativeToFeature(profile)),

            .project(target: "ProfileDomainTesting", path: .relativeToDomain("ProfileDomain"))
        ]),
        .demo(module: "ProfileDemo", dependencies: [
            .project(target: profile, path: .relativeToFeature(profile)),

            .project(target: "ProfileDomainTesting", path: .relativeToDomain("ProfileDomain"))
        ])
    ]
)
