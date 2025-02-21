//
//  Interface.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/18/25.
//

import Foundation
import SwiftyJSON

public protocol FetchMemberProfileUsecase {
    func fetchMemberProfile() async throws -> Member
}

public protocol MemberProfileRepository {
    func fetchMemberInfo() async throws -> JSON
}

