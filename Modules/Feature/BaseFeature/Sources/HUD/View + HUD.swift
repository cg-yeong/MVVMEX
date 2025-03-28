//
//  View + HUD.swift
//  BaseFeature
//
//  Created by root0 on 3/27/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import SwiftUI

extension View {

    func hud<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) -> some View {
        overlay(alignment: .top) {
            HUD(content: content)
                .onTapGesture {
                    isPresented.wrappedValue = false
                }
//                .offset(y: isPresented.wrappedValue ? 0 : -128)
                .opacity(isPresented.wrappedValue ? 1 : 0)
                .animation(Animation.easeInOut, value: isPresented.wrappedValue)
                .animation(Animation.spring(), value: isPresented.wrappedValue)
        }
    }
}


private struct HUD<Content: View>: View {
    @ViewBuilder let content: Content
    
    var body: some View {
        content
            .padding(.horizontal, 12)
            .padding(16)
            .background(
                Capsule()
                    .foregroundStyle(Color.black)
                    .shadow(color: .black.opacity(0.16), radius: 12, x: 0, y: 5)
            )
    }
}
