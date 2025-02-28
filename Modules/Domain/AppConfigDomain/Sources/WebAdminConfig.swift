//
//  WebAdminConfig.swift
//  AppConfigDomain
//
//  Created by root0 on 2/27/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import SwiftUI
import AppConfigDomainInterface

public class WebAdminConfig: ObservableObject {
    @Published public var argument: WebSettingArgument = .init(isMMUseYn: "n")

    public init() {}
}

public extension EnvironmentValues {
    @Entry var webAdminConfig: WebAdminConfig = .init()
}
