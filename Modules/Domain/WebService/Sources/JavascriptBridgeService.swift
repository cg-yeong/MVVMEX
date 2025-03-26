//
//  JavascriptBridgeService.swift
//  WebService
//
//  Created by root0 on 3/26/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import SwiftyJSON
import WebKit
import WebServiceInterface

public class JavascriptBridgeService: NSObject {

    public weak var responseDelegate: BridgeResponseDelegate? {
        didSet {
            initBridgeHandlers()
        }
    }
    var bridge: WebViewJavascriptBridge?
    var bridgeHandlers: [String: (JSON, @escaping WVJBResponseCallback) -> Void]? = [:]

    var responseHandlerName: String = "callFromWeb"
    var requesthandlerName: String = "$.webScript"

    public func registerHandlers(for webView: WKWebView, sender: WKUIDelegate) {
        bridge = WebViewJavascriptBridge(forWebView: webView)
        bridge?.setWebViewDelegate(sender)

        let handler: WVJBHandler = { [weak self] (data, responseCallback) -> Void in
            let json = JSON(data as Any)
            print("수신 브릿지 with 데이터:\n\(json)\n")

            if let router = self?.bridgeHandlers?[json["cmd"].stringValue] {
                router(json, responseCallback ?? { _ in })
            } else {

            }
        }
        bridge?.registerHandler(responseHandlerName, handler: handler)
        bridge?.registerHandler("fileChooserFromWeb", handler: handler)
        print("RegisterHandlers")
    }

    func initBridgeHandlers() {
        bridgeHandlers?[BridgeResponseCMD.aLogin.rawValue] = responseDelegate?.aLogin
        bridgeHandlers?[BridgeResponseCMD.sLogin.rawValue] = responseDelegate?.sLogin
        bridgeHandlers?[BridgeResponseCMD.fWin.rawValue] = responseDelegate?.fWin
        bridgeHandlers?[BridgeResponseCMD.oWin.rawValue] = responseDelegate?.oWin
        bridgeHandlers?[BridgeResponseCMD.getAdId.rawValue] = responseDelegate?.getAdId
    }

}
