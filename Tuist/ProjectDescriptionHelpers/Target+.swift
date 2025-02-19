//
//  Target+.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/18/25.
//

@preconcurrency import ProjectDescription

public extension Target {
    static func interface(module name: String, dependencies: [TargetDependency] = []) -> Target {
        return Target.target(
            name: name,
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.yeong.exMVVMC.\(name)",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Interface/**"],
            resources: nil,
            scripts: [.swiftLint],
            dependencies: dependencies,
            settings: .settings(
                base: .init()
                    .otherLinkerFlags(["$(inherited) -Objc -all_load"]),
                configurations: .init(),
                defaultSettings: .recommended
            )
        )
    }

    static func implements(module name: String, dependencies: [TargetDependency] = []) -> Target {
        return Target.target(
            name: name,
            destinations: [.iPhone],
            product: .staticLibrary,
            bundleId: "com.yeong.exMVVMC.\(name)",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: nil,
            scripts: [.swiftLint],
            dependencies: dependencies,
            settings: .settings(
                base: .init()
                    .otherLinkerFlags(["$(inherited) -Objc"]),
                configurations: .init(),
                defaultSettings: .recommended
            )
        )
    }

    static func testing(module name: String, dependencies: [TargetDependency] = []) -> Target {
        return Target.target(
            name: name,
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.yeong.exMVVMC.\(name)",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Testing/**"],
            resources: nil,
            scripts: [.swiftLint],
            dependencies: dependencies,
            settings: .settings(
                base: .init()
                    .otherLinkerFlags(["$(inherited) -Objc"]),
                configurations: .init(),
                defaultSettings: .recommended
            )
        )
    }

    static func tests(module name: String, dependencies: [TargetDependency] = []) -> Target {
        return Target.target(
            name: name,
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "com.yeong.exMVVMC.\(name)",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: nil,
            scripts: [.swiftLint],
            dependencies: dependencies,
            settings: .settings(
                base: .init()
                    .otherLinkerFlags(["$(inherited) -Objc"]),
                configurations: .init(),
                defaultSettings: .recommended
            )
        )
    }

    static func demo(module name: String, dependencies: [TargetDependency] = []) -> Target {
        return Target.target(
            name: name,
            destinations: [.iPhone],
            product: .app,
            bundleId: "com.yeong.exMVVMC.\(name)",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .extendingDefault(with: [
                "UILaunchStoryboardName": "LaunchScreen.storyboard"
            ]),
            sources: ["Demo/Sources/**"],
            resources: ["Demo/Resources/**"],
            scripts: [.swiftLint],
            dependencies: dependencies,
            settings: .settings(
                base: .init()
                    .otherLinkerFlags(["$(inherited) -Objc"]),
                configurations: .init(),
                defaultSettings: .recommended
            )
        )
    }
}
