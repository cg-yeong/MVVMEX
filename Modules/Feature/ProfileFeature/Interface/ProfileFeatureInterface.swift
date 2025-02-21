//
//  Interface.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/18/25.
//

import Foundation
import Combine
import ProfileDomainInterface

public protocol ProfileInterface: ObservableObject {
    var member: Member { get }
    func fetchMemberInfo() async
}
