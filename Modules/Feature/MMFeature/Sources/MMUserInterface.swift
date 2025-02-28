//
//  MMUserInterface.swift
//  MegaphoneInterface
//
//  Created by root0 on 2/25/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import MegaphoneInterface
import AppConfigDomainInterface

/// 1. 구현은 MMFeature 바깥에서 한다 : ObservableObject, MMUserInterface를 구현받아서 ?
/// 2. MMFeature 바깥에서 Map, CashPurchse, MsgBox 에서 ObservedObject 로 선언해서 사용할수 있도록?
public class MMUserInterfaceImplement: ObservableObject, MMUserInterface {

    private var webSettingUsecase: FetchWebSettingUsecase

    public init(webSettingUsecase: FetchWebSettingUsecase) {
        self.webSettingUsecase = webSettingUsecase
    }

    /// 완전히 외부(상위 조건)에 의존
    public func isAvailableMMFeature() -> Bool {
        let availablePages: Set<String> = ["map", "msg", "mine"]
        return availablePages.contains("msg")
    }

    /// ; From Web Load Setting once when App StartLoading
    /// From Device Memory? App Container?
    ///
    /// -> 앱 시작시 초기에 ResourceUsecase - ResourceDomain - 에 implement에 메모리에 올려놓고 resource usecase resourcedomain에서 긁어오기?
    public func supportsMM() async -> Bool {
        do {
            let webArgument = try await webSettingUsecase.fetchWebSetting()
            let usable = webArgument.isMMUseYn == "y"
            return usable
        } catch {
            return false
        }
    }

    public func isMMUsable() async -> Bool {
        let support = await supportsMM()
        let available = isAvailableMMFeature()

        return support && available
    }
}
