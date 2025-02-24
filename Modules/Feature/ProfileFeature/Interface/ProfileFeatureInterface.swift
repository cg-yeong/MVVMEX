//
//  Interface.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/18/25.
//

import Foundation
import Combine
import ProfileDomainInterface

public protocol ProfileInterface {
    func backToRoot()

    func fetchMemberInfo() async -> Member
    func goChat(with member: Int)
    func openWeb()
}
