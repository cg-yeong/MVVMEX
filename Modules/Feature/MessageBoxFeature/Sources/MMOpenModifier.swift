//
//  MMOpenModifier.swift
//  MessageBoxFeature
//
//  Created by root0 on 2/28/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import SwiftUI
import MegaphoneInterface

struct MMOpenModifier: ViewModifier {

    @Binding var isPresented: Bool

    var boxViewModel: MessageBoxViewModel

    func body(content: Content) -> some View {
        content
            .overlay {
                
            }
    }
}
