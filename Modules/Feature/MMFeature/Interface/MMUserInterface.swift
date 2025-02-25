//
//  Interface.swift
//  ProjectDescriptionHelpers
//
//  Created by root0 on 2/18/25.
//

import Foundation
import SwiftUI
import Combine

/// MM에 접근과 사용가능한지 검증할 수 있는 조건 체크
public protocol MMUIAccessible {

    /// 각 탭(화면)에서 접근 가능한지 체크; (tab1
    /// -> 테스트에서 탭을 주입받아 접근 분기 체크?
    func isAvailableMMFeature() -> Bool

    /// 웹 서버에서 MM 기능 on/off 로 관리할 시 사용가능한지
    func supportsMM() -> Bool
}

public protocol MMUserInterface: MMUIAccessible {
    /// MMUIAccessible 에서 MM 접근 가능화면인지 && 서버에서 MM 기능 켰는지 둘다 만족
    func isMMUsable() -> Bool
}

/// User Input Actions, -> For change
/// MM에 접근하기 위한 User Input Actions; 진입점
public protocol MMUIEntryInterface: MMUIAccessible {
    /// MM 버튼 탭
    func didTapMMButton()

    /// 이미 MM View가 화면에 떠 있는지 확인;
    /// 중첩으로 Present 방지
    func isPresentedMM() -> Bool

    /// MM 화면 떠 있는지 아닌지 양방향 바인딩을 위한 Subject
    func getPresentingSubject() -> PassthroughSubject<UUID, Never>

    /// MM 이요가능한 상품 구매했는지 바인딩 위한 Subject?
    func getPurchaseSubject() -> PassthroughSubject<UUID, Never>
}
