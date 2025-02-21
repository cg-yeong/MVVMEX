//
//  Coordinator.swift
//  BaseFeatureInterface
//
//  Created by root0 on 2/20/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import SwiftUI
import BaseFeatureInterface

final public class Coordinator: CoordinatorInterface {
    @State public var path: [BaseFeatureInterface.FeaturePages] = []

    public func push(_ destination: BaseFeatureInterface.FeaturePages) {
        path.append(destination)
    }
    
    public func popToRoot() {
        path.removeAll()
    }
    
    public func pop() {

    }
    
    public func remove(_ condition: Bool) {

    }

    public func set(paths: [FeaturePages]) {
        path = paths
    }
}
//
//struct CoordinatorModifier: ViewModifier {
//
//    @Binding var path: [FeaturePages]
//
//    func body(content: Content) -> some View {
//        NavigationStack(path: $path) {
//            content
//        }
//        .
//
//    }
//
//}
