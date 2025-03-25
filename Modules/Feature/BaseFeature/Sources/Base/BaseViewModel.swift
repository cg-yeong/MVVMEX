//
//  BaseViewModel.swift
//  BaseFeature
//
//  Created by root0 on 2/24/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import SwiftUI
import BaseFeatureInterface

import AppConfigDomainInterface
// path , push
public class BaseViewModel: BaseInterface {

    private var coordinator: any BaseFlowInterface

    private var webSettingUsecase: FetchWebSettingUsecase

    public var coordinatorPath: [String] {
        return coordinator.getPathStack()
    }

    public init(flow: any BaseFlowInterface, webSettingUsecase: FetchWebSettingUsecase) {
        self.coordinator = flow
        self.webSettingUsecase = webSettingUsecase
    }

    public func openProfile() {
        coordinator.goProfileFlow()
    }

    public func openMessageBox() {
        coordinator.goMessageBoxFlow()
    }

    public func openChatting() {
        coordinator.goChatFlow(with: 123)
    }

    public func openWebView(_ detail: String) {
        coordinator.goWebListFlow(page: detail)
    }

    public func backToRoot() {
        coordinator.goBackFlow()
    }

    public func fetchWebSetting() async {
        do {
            let _ = try await webSettingUsecase.fetchWebSetting()
        } catch {

        }
    }
}
