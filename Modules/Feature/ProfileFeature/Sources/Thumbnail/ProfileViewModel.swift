//
//  ProfileViewModel.swift
//  Profile
//
//  Created by root0 on 2/19/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import SwiftUI
import ProfileInterface

class ProfileViewModel: ObservableObject, ProfileInterface {

    /// 
    func fetchMemberNumberList(count: Int = 10) -> [Int] {
        let random10 = Array(1...100).shuffled().prefix(10)
        return Array(random10)
    }

    ///
    func fetchMemberInfo(number: Int) -> Member {

        return Member(sex: "men", memNo: 1, name: "")
    }
    

}
