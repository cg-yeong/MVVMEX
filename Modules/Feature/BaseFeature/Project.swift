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
//        .implements(module: "BaseFeature", dependencies: [
//            .project(target: "BaseFeatureInterface", path: .relativeToFeature("BaseFeature")),
//        ]),
        Target.target(
            name: "BaseFeature",
            destinations: [.iPhone],
            product: .staticLibrary,
            bundleId: "com.yeong.exMVVMC.BaseFeature",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**", "BridgeLibrary/**", "PublicHeaders/**"],
            resources: nil,
            headers: .headers(
                public: ["PublicHeaders/**"],
                private: ["BridgeLibrary/**"],
                project: ["BridgeLibrary/**"]
            ),
            scripts: [.swiftLint],
            dependencies: [
                .project(target: "BaseFeatureInterface", path: .relativeToFeature("BaseFeature")),
                .package(product: "ComposableArchitecture", type: .runtime)
            ],
            settings: .settings(
                base: SettingsDictionary()
                    .swiftObjcBridgingHeaderPath("PublicHeaders/BaseFeature-Bridging-Header.h")
                    .otherLinkerFlags(["$(inherited) -Objc"]),
                configurations: .init(),
                defaultSettings: .recommended
            )
        )
    ]
)
