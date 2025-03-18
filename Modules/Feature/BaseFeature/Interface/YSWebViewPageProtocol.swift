//
//  YSWebViewPageProtocol.swift
//  BaseFeatureInterface
//
//  Created by root0 on 3/18/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation

public struct HTTPMethod: RawRepresentable, Equatable, Hashable, Sendable {
    static let get = HTTPMethod(rawValue: "GET")
    static let post = HTTPMethod(rawValue: "POST")

    public let rawValue: String
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

public protocol WebpageTargetType {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
}

public enum WebViewURLRequest: Equatable {
    case login
    case signUp
    case profileList
    case messageBox
    case partyLobby
    case mypage
}

extension WebViewURLRequest: WebpageTargetType {
    public var baseURL: URL {
        return URL(string: "https://www.naver.com")!
    }

    public var path: String {
        switch self {
        default: ""
        }
    }

    public var method: HTTPMethod {
        return .get
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json", "Cookie": ""]
    }

}
