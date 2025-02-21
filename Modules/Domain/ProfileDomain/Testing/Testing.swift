//
//  Testing.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/18/25.
//

import Foundation
import ProfileDomainInterface
import SwiftyJSON

public struct MockMemberProfileUsecaseImpl: FetchMemberProfileUsecase {

    public init() {}

    public func fetchMemberProfile() async throws -> JSON {
        return JSON([
            "picture": "https://randomuser.me/api/portraits/women/0.jpg",
            "name": "Test"
        ])
    }
}

final class MockMemberProfileRepositoryImpl: MemberProfileRepository {
    public init() {}
    func fetchMemberInfo() async throws -> Data {
        return Data()
    }
}
