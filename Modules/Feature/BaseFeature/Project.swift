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
        Target.target(
            name: "BaseFeature",
            destinations: [.iPhone],
            product: .staticLibrary,
            bundleId: "com.yeong.exMVVMC.BaseFeature",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**", "PublicHeaders/**"],
            resources: nil,
            headers: nil,
            scripts: [.swiftLint],
            dependencies: [
                .project(target: "BaseFeatureInterface", path: .relativeToFeature("BaseFeature")),
                .package(product: "ComposableArchitecture", type: .runtime),
//                Module.Domain.WebService.toTargetDependency,
                .project(target: "WebService", path: .relativeToDomain("WebService"))
            ],
            settings: .settings(
                base: SettingsDictionary()
                    .otherLinkerFlags(["$(inherited) -Objc"]),
                configurations: .init(),
                defaultSettings: .recommended
            )
        )
    ]
)
