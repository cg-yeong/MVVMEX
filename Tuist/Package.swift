// swift-tools-version: 5.9
@preconcurrency import PackageDescription

#if TUIST
@preconcurrency import ProjectDescription

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,] 
        productTypes: [
            "SwiftyJSON": .framework
        ]
    )
#endif

let package = Package(
    name: "MVVMEX",
    dependencies: [
        // Add your own dependencies here:
        // .package(url: "https://github.com/Alamofire/Alamofire", from: "5.0.0"),
        // You can read more about dependencies here: https://docs.tuist.io/documentation/tuist/dependencies
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "5.0.2"),
//        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.18.0")
    ]
)
