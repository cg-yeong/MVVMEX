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
    public func fetchMemberProfile() async throws -> ProfileDomainInterface.Member {
        return Member(
            name: "Test",
            picture: ""
        )
    }

    public init() {}

}

final class MockMemberProfileRepositoryImpl: MemberProfileRepository {
    func fetchMemberInfo() async throws -> SwiftyJSON.JSON {
        return JSON()
    }
    
    public init() {}
}
