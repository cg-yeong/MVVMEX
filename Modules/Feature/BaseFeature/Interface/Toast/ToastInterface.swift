//
//  ToastInterface.swift
//  BaseFeatureInterface
//
//  Created by root0 on 3/27/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation

public protocol ToastInterface {
    func showToast()
    func hideToast()
    func clearToastQueue()
}
