//
//  Sources.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/18/25.
//

import Foundation
import SwiftUI
import AppConfigDomainInterface

public struct FetchWebSettingUsecaseImpl: FetchWebSettingUsecase {
    private var webAdminConfig: WebAdminConfig = .init()

    private let webSettingRepository: WebSettingRepository

    public init(webSettingRepository: WebSettingRepository) {
        self.webSettingRepository = webSettingRepository
    }

    public func fetchWebSetting() async throws -> WebSettingArgument {
        let data = try await webSettingRepository.fetchWebSetting()
        // toModel
        var argument = WebSettingArgument(isMMUseYn: "y")
        webAdminConfig.argument = argument
        return argument
    }

    public func attachWebSetting() {

    }
}

final public class WebSettingRepositoryImpl: WebSettingRepository {
    public init() {}

    public func fetchWebSetting() async throws -> [String: Any] {
        // do networking fetch data
        return [:]
    }

}
