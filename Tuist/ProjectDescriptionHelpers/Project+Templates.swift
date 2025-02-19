// swiftlint:disable all
//  Project+Templates.swift
//  Packages
//
//  Created by root0 on 2/18/25.
//

@preconcurrency import ProjectDescription

public enum Module {
    public enum Core {
        public static let ProfileKit: TargetDependency = .project(target: "ProfileKit", path: .relativeToCore("ProfileKit"))
    }

//    public static let BaseFeature: TargetDependency = .project(target: "BaseFeature", path: .relativeToSections("Feature"))
    public enum Feature: String {
        case BaseFeature

        case ProfileFeature
        case MessageBoxFeature
        case ChattingFeature

        public var toTargetDependency: TargetDependency {
            .project(target: self.rawValue, path: .relativeToFeature(self.rawValue))
        }
    }
}

public extension Project {

    static func module(name: String, targets: [Target]) -> Project {
        return Project(
            name: name,
            organizationName: "com.yeong",
            settings: .settings(base: ["SDKROOT": "iphoneos"]),
            targets: targets,
            schemes: [],
            additionalFiles: [],
            resourceSynthesizers: .default
        )
    }
}
