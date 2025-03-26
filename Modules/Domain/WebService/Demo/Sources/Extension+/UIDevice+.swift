//
//  UIDevice+.swift
//  WebService
//
//  Created by root0 on 3/26/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import UIKit

public extension UIDevice {
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        return identifier
    }()
}
