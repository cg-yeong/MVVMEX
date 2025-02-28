//
//  Interface.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/18/25.
//

import Foundation

public protocol FetchWebSettingUsecase {
    func fetchWebSetting() async throws -> WebSettingArgument
    func attachWebSetting()
}

public protocol WebSettingRepository {
    func fetchWebSetting() async throws -> [String: Any]
}
