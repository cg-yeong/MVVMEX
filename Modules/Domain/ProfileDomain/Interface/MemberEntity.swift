//
//  MemberEntity.swift
//  ProfileDomainInterface
//
//  Created by root0 on 2/19/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation

public struct Member: Codable, Equatable {
    public var name: String
    public var picture: String

    public init(name: String, picture: String) {
        self.name = name
        self.picture = picture
    }

    public static var `default` = Member(name: "", picture: "")

}
// end
