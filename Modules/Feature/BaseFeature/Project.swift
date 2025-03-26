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
//            headers: .headers(
//                public: ["PublicHeaders/**"]
////                private: ["BridgeLibrary/**"],
////                project: ["BridgeLibrary/**"]
//            ),
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
                    .merging([
                        "HEADER_SEARCH_PATHS": "$(SRCROOT)/../../Domain/WebService/BridgeLibrary",
                        "SWIFT_OBJC_BRIDGING_HEADER": "$(SRCROOT)/../../Domain/WebService/PublicHeaders/WebService-Bridging-Header.h"
                    ])
//                    .swiftObjcBridgingHeaderPath("PublicHeaders/BaseFeature-Bridging-Header.h")
                    .otherLinkerFlags(["$(inherited) -Objc"]),
                configurations: .init(),
                defaultSettings: .recommended
            )
        )
    ]
)
