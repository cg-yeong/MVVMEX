//
//  ToastView.swift
//  BaseFeature
//
//  Created by root0 on 3/28/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import SwiftUI

public struct ToastStyle {
    public var backgroundColor: Color = .black.opacity(0.8)
    public var titleColor: Color = .white
    public var messageColor: Color = .white
    public var horizontalPadding: CGFloat = 20.0
    public var verticalPadding: CGFloat = 10.0
    public var cornerRadius: CGFloat = 10.0

    public var titleFont: Font = .system(size: 16, weight: .bold)
    public var messageFont: Font = .system(size: 16, weight: .bold)
    public var titleAlignment: NSTextAlignment = .center
    public var messageAlignment: NSTextAlignment = .center
    public var titleNumberOfLines: Int = 0
    public var messageNumberOfLines: Int = 0
    public var displayShadow: Bool = false
    public var shadowOpacity: CGFloat = 0.8 {
        didSet {
            shadowOpacity = max(min(shadowOpacity, 1.0), 0.0)
        }
    }
    public var shadowRadius: CGFloat = 6.0
    public var shadowOffset: CGSize = CGSize(width: 4.0, height: 4.0)
    public var imageSize: CGSize = CGSize(width: 80.0, height: 80.0)
    public var activitySize: CGSize = CGSize(width: 100.0, height: 100.0)
    public var fadeDuration: TimeInterval = 2.0
    public var activityIndicatorColor: Color = .white
    public var activityBackgroundColor: Color = .black.opacity(0.8)

    public init() {}
}

public struct ToastModel {
    public var title: String?
    public var message: String?
    public var image: Image?
    public var style: ToastStyle = .init()

    public init() {}
}

public struct ToastView: View {

    public var model: ToastModel
    public init(model: ToastModel = .init()) {
        self.model = model
    }

    public var body: some View {
        VStack {
            
        }
    }
}
