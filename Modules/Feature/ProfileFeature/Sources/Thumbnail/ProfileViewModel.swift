//
//  ProfileViewModel.swift
//  Profile
//
//  Created by root0 on 2/19/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import SwiftUI
import ProfileInterface
import ProfileDomainInterface
import Combine

@MainActor
public class ProfileViewModel: ProfileInterface {
    @Published private(set) public var member: Member = Member.default {
        willSet {
            print("member: \(newValue)")
        }
    }

    private var profileUsecase: FetchMemberProfileUsecase

    public init(profileUsecase: FetchMemberProfileUsecase) {
        self.profileUsecase = profileUsecase
    }

    public func fetchMemberInfo() async {
        do {
            let json = try await profileUsecase.fetchMemberProfile()
            self.member = Member(name: json["name"].stringValue,
                                 picture: json["picture"].stringValue)
        } catch {
            print(error.localizedDescription)
        }
    }
    public func getMember() -> Member {
        return member
    }
}
