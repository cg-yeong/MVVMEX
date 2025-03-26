//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/19/25.
//

@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers

let webService: String = Module.Domain.WebService.rawValue

let project = Project.module(
    name: webService,
    targets: [
        .interface(module: "WebServiceInterface", dependencies: [
            .SPM.SwiftyJSON
        ]),
        .target(
            name: "WebService",
            destinations: [.iPhone],
            product: .staticLibrary,
            bundleId: "com.yeong.exMVVMC.WebService",
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
                .project(target: "NetworkingInterface", path: .relativeToCore("Networking")),
                .project(target: "WebServiceInterface", path: .relativeToDomain("WebService")),
            ],
            settings: .settings(
                base: SettingsDictionary()
                    .merging([
                        "HEADER_SEARCH_PATHS": "$(SRCROOT)/BridgeLibrary"
                    ])
                    .swiftObjcBridgingHeaderPath("PublicHeaders/WebService-Bridging-Header.h")
                    .otherLinkerFlags(["$(inherited) -Objc"]),
                configurations: .init(),
                defaultSettings: .recommended
            )
        ),
        .target(
            name: "WebServiceDemo",
            destinations: .iOS,
            product: .app,
            bundleId: "com.yeong.exMVVMC.WebServiceDemo",
            infoPlist: .extendingDefault(with: [
                "UILaunchStoryboardName": "LaunchScreen.storyboard"
            ]),
            sources: ["Demo/Sources/**"],
            resources: ["Demo/Resources/**"],
            headers: .headers(project: ["Sources/Interface/**/*.h"]),
            scripts: [.swiftLint],
            dependencies: [
                Module.Domain.WebService.toTargetDependency,
//                .project(target: webService, path: .relativeToDomain(webService))
            ],
            settings: .settings(
                base: .init()
                    .merging([
                        "HEADER_SEARCH_PATHS": "$(SRCROOT)/BridgeLibrary",
                        "SWIFT_OBJC_BRIDGING_HEADER": "$(SRCROOT)/PublicHeaders/WebService-Bridging-Header.h"
                    ])
            )
        ),

//        .implements(module: <#module name#>, dependencies: [
//            .project(target: <#module name interface#>, path: .relativeToFeature(<#module name#>))
//        ]),
//        .testing(module: <#module name testing#>, dependencies: [
//            .project(target: <#module name interface#>, path: .relativeToFeature(<#module name#>))
//        ]),
//        .tests(module: <#module name tests#>, dependencies: [
//            .project(target: <#module name#>, path: .relativeToFeature(<#module name#>))
//        ]),
//        .demo(module: "WebServiceDemo", dependencies: [
//            .project(target: webService, path: .relativeToDomain(webService))
//        ]),
    ]
)
