//
//  UIViewController+.swift
//  BaseFeature
//
//  Created by root0 on 3/24/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import UIKit

public extension UIViewController {

    // 하위 뷰컨트롤러에 추가
    func add(child: UIViewController, container: UIView) {
        addChild(child)
        child.view.frame = container.bounds
        container.addSubview(child.view)
        child.didMove(toParent: self)
        child.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            child.view.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.trailingAnchor),
            child.view.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor),
            child.view.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    // 컨테이너 뷰컨트롤러 없앨때
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
