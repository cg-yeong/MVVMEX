//
//  Interface.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/18/25.
//

import Foundation

// TODO: Move to Domain
public enum Sex: String {
    case men
    case women
}
public struct Member: Codable {
    var sex: Sex.RawValue
    var memNo: Int
    var name: String

    private enum CodingKeys: CodingKey {
        case sex
        case memNo
        case name
    }

    public init(sex: Sex.RawValue, memNo: Int, name: String) {
        self.sex = sex
        self.memNo = memNo
        self.name = name
    }

}
// end

public protocol ProfileInterface {
    func fetchMemberNumberList(count: Int) -> [Int]
    func fetchMemberInfo(number: Int) -> Member
}
