//
//  Sources.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/18/25.
//

import Foundation
import ProfileDomainInterface
import SwiftyJSON

/// Model : JSON -> toModel()
public struct FetchMemberProfileUsecaseImpl: FetchMemberProfileUsecase {
    
    private let profileRepository: MemberProfileRepository

    public init(profileRepository: MemberProfileRepository) {
        self.profileRepository = profileRepository
    }

    public func fetchMemberProfile() async throws -> Member {
        let data = try await profileRepository.fetchMemberInfo()
        let name: String = data["results"][0]["name"]["first"].stringValue
        let picture: String = data["results"][0]["picture"]["large"].stringValue

        // toModel
        return Member(name: name, picture: picture)
    }
}

/// JSON 으로 MemberEntity 대체
final public class MemberProfileRepositoryImpl: MemberProfileRepository {
//    let network: Networkinterface
    public init() {}
    public func fetchMemberInfo() async throws -> JSON {
        let (data, response) = try await URLSession.shared.data(from: URL(string: "https://randomuser.me/api")!)
        if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode != 200 {
            print("StatusCode: \(statusCode)")
            throw URLError(.unknown)
        }

        return try JSON(data: data)
    }
}
