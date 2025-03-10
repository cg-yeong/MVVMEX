//
//  OnBoarding.swift
//  MVVMEX
//
//  Created by root0 on 3/10/25.
//

import SwiftUI

struct OnBoarding: View {

    @Binding var isIntro: Bool

    var body: some View {
        Color.brown.opacity(0.2)
            .overlay {
                Text("OnBoarding")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                isIntro = false
            }
    }
}

#Preview {
    OnBoarding(isIntro: .constant(true))
}
