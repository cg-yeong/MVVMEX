@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "MVVMEX",
    packages: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .exact("1.18.0"))
    ],
    targets: [
        .target(
            name: "MVVMEX",
            destinations: .iOS,
            product: .app,
            bundleId: "com.yeong.exMVVMC",
            infoPlist: .file(path: .relativeToRoot("MVVMEX/Resources/MVVMEX-Info.plist")),
            sources: ["MVVMEX/Sources/**"],
            resources: [
                .glob(pattern: .relativeToRoot("MVVMEX/Resources/**"),
                      excluding: [
                        .relativeToRoot("MVVMEX/Resources/MVVMEX-Info.plist")
                      ])
            ],
            headers: .headers(project: ["MVVMEX/Sources/Interface/**/*.h"]),
            scripts: [
                .pre(script: "if which swiftlint > /dev/null; then swiftlint --quiet; else echo 'warning: SwiftLint not installed'; fi",
                     name: "Run SwiftLint",
                     basedOnDependencyAnalysis: false)
            ],
            dependencies: [
                Module.Feature.BaseFeature.toTargetDependency,
                Module.Feature.ProfileFeature.toTargetDependency,
                Module.Feature.MessageBoxFeature.toTargetDependency,
                Module.Feature.ChattingFeature.toTargetDependency,
                Module.Feature.MegaphoneFeature.toTargetDependency,

                Module.Domain.ProfileDomain.toTargetDependency,
                Module.Domain.AppConfigDomain.toTargetDependency,
                .package(product: "ComposableArchitecture", type: .runtime)
            ],
            settings: .settings(
                base: .init()
                    .merging([
                        "HEADER_SEARCH_PATHS": "$(SRCROOT)/Modules/Feature/BaseFeature/BridgeLibrary",
                        "SWIFT_OBJC_BRIDGING_HEADER": "$(SRCROOT)/Modules/Feature/BaseFeature/PublicHeaders/BaseFeature-Bridging-Header.h"
                    ])
            )
        ),
        .target(
            name: "MVVMEXTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.yeong.exMVVMCTests",
            infoPlist: .default,
            sources: ["MVVMEX/Tests/**"],
            resources: [],
            dependencies: [.target(name: "MVVMEX")]
        ),
    ]
)
