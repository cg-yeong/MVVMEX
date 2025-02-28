//
//  MMViewModel.swift
//  MMFeature
//
//  Created by root0 on 2/25/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import MegaphoneInterface
import AppConfigDomainInterface

public class MMViewModel: ObservableObject, MMInterface {
    private var cancellable: Set<AnyCancellable> = []

    // MARK: View State Binding
    @ObservedObject private var mmUI: MMUserInterfaceImplement

    // MARK: Usecase
    
    public init(webSettingUsecase: FetchWebSettingUsecase) {
        self.mmUI = MMUserInterfaceImplement(webSettingUsecase: webSettingUsecase)
    }


    public func sendMM() async {

    }

    public func checkMMSendable() async {

    }
}
