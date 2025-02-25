//
//  MMUserInterface.swift
//  MegaphoneInterface
//
//  Created by root0 on 2/25/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import MegaphoneInterface
//import Core

/// 구현은 MMFeature 바깥에서 한다 : ObservableObject, MMUserInterface를 구현받아서
class MMUserInterfaceImplement: ObservableObject, MMUserInterface {
    func isAvailableMMFeature() -> Bool {
        let availablePages: Set<String> = ["map", "msg", "mine"]
        
    }
    
    func supportsMM() -> Bool {
        <#code#>
    }

    func isMMUsable() -> Bool {
        <#code#>
    }


}
