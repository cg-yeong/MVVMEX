//
//  WebSettingArgument.swift
//  AppConfigDomainInterface
//
//  Created by root0 on 2/26/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation

public struct WebSettingArgument: Decodable, Equatable {
    public var isMMUseYn: String

    public init(isMMUseYn: String) {
        self.isMMUseYn = isMMUseYn
    }
}
