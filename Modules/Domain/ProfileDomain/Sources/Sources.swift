//
//  Sources.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/18/25.
//

import Foundation
import ProfileDomainInterface
import SwiftyJSON

public struct FetchMemberProfileUsecaseImpl: FetchMemberProfileUsecase {
    private let profileRepository: MemberProfileRepository

    public init(profileRepository: MemberProfileRepository) {
        self.profileRepository = profileRepository
    }

    public func fetchMemberProfile() async throws -> JSON {
        let data = try await profileRepository.fetchMemberInfo()
        return try JSON(data: data)
    }
}

final class MemberProfileRepositoryImpl: MemberProfileRepository {
    func fetchMemberInfo() async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: URL(string: "")!)
        if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode != 200 {
            print("StatusCode: \(statusCode)")
            throw URLError(.unknown)
        }

        return data
    }
}
