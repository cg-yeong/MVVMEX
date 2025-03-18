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
        Color.brown
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

public struct OnBoardingTabView: View {
    @Binding var isOnBoarding: Bool
    
    public init(isOnBoarding: Binding<Bool>) {
        self._isOnBoarding = isOnBoarding
    }
    public var body: some View {
        TabView {
            Color.pink
                .overlay {
                    Text("OnBoarding 1")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            Color.cyan
                .overlay {
                    Text("OnBoarding 2")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            Color.purple
                .overlay {
                    Text("OnBoarding 3")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(alignment: .bottom) {
                    Button {
                        isOnBoarding = false
                    } label: {
                        Text("Project A 시작하기")
                            .background(.mint)
                    }
                    .padding(.bottom, 50)
                }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}
