// swiftlint:disable all
//  Project+Templates.swift
//  Packages
//
//  Created by root0 on 2/18/25.
//

@preconcurrency import ProjectDescription

public enum Module {
    public enum Core: String, CaseIterable {
        case Networking

        public var toTargetDependency: TargetDependency {
            .project(target: self.rawValue, path: .relativeToCore(self.rawValue))
        }
    }

    public enum Domain: String, CaseIterable {
        case ProfileDomain

        public var toTargetDependency: TargetDependency {
            .project(target: self.rawValue, path: .relativeToDomain(self.rawValue))
        }
    }

    public enum Feature: String, CaseIterable {
        case CoordinatorFeature
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
