//
//  YSWebViewPageProtocol.swift
//  BaseFeatureInterface
//
//  Created by root0 on 3/18/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import WebKit

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

public enum YSWebViewURLRequest: Equatable {
    case login
    case signUp
    case profileList
    case messageBox
    case partyLobby
    case mypage
}

extension YSWebViewURLRequest: WebpageTargetType {

    public var url: URL {
        baseURL.appending(path: path)
    }

    public var baseURL: URL {
        switch self {
        case .login:
            return URL(string: "www.naver.com")!
        case .mypage:
            return URL(string: "www.naver.com")!
        default:
            return URL(string: "www.naver.com")!
        }
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

/// 뷰에서 WebView가 뭔가 해야할 일 있을때 사용
@objc public protocol WKWebViewDelegate {
    @objc optional func webViewDidFinishLoad(_ webView: WKWebView)
    @objc optional func webViewDidStartLoad(_ webView: WKWebView)
    @objc optional func webView(_ webView: WKWebView, didFailLoadWithError error: Error)
    @objc optional func getStartPage() -> URLRequest?
}
