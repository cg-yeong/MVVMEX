@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "MVVMEX",
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
            scripts: [
                .pre(script: "if which swiftlint > /dev/null; then swiftlint --quiet; else echo 'warning: SwiftLint not installed'; fi",
                     name: "Run SwiftLint",
                     basedOnDependencyAnalysis: false)
            ],
            dependencies: [
                Module.Feature.BaseFeature.toTargetDependency,
                Module.Feature.CoordinatorFeature.toTargetDependency,
                Module.Feature.ProfileFeature.toTargetDependency,
                Module.Feature.MessageBoxFeature.toTargetDependency,
                Module.Feature.ChattingFeature.toTargetDependency,

                Module.Domain.ProfileDomain.toTargetDependency,
            ]
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
