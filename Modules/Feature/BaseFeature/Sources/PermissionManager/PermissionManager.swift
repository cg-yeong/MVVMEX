//
//  PermissionManager.swift
//  BaseFeature
//
//  Created by root0 on 3/25/25.
//  Copyright © 2025 com.yeong. All rights reserved.
//

import Foundation
import AppTrackingTransparency
import Photos
import CoreLocation
import AVFoundation

public enum Permissions {
    case video
    case camera
    case microphone
    case audio
    case photo
    case album
    case push
    case tracking
    case near

    var nickname: String {
        switch self {
        case .video: "비디오"
        case .camera: "카메라"
        case .microphone: "마이크"
        case .audio: "오디오"
        case .photo: "사진"
        case .album: "앨범"
        case .push: "알림"
        case .tracking: "추적 투명성"
        case .near: "근처 기기"
        }
    }
}

/**
 Authorization Manager feat Async Await
 Usage.
 ```
 Task {

     let status = await PermissionManager.shared.askAuthorization([.video, .audio])

     if status.isEmpty {

     } else {
         await MainActor.run {

         }
     }

 }
 ```
 */
public class PermissionManager {
    static let shared = PermissionManager()

    enum PermissionStat {
        case unknown, undefined
        case justDenied, alreadyDenied
        case restricted
        case justAuthorized, alreadyAuthorized
    }

    private func openURLToSetting() {
        DispatchQueue.main.async {
            if let toSettingURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(toSettingURL, options: [:], completionHandler: nil)
            }
        }
    }

    func requests(_ permissions: [Permissions]) async -> [Permissions] {
        var list: [Permissions] = []

        if permissions.contains(.camera) {
            if let status = await request(.camera) {
                list.append(status)
            }
        }
        if permissions.contains(.video) {
            if let status = await request(.video) {
                list.append(status)
            }
        }

        if permissions.contains(.microphone) {
            if let status = await request(.microphone) {
                list.append(status)
            }
        }
        if permissions.contains(.audio) {
            if let status = await request(.audio) {
                list.append(status)
            }
        }
        if permissions.contains(.photo) {
            if let status = await request(.photo) {
                list.append(status)
            }
        }
        if permissions.contains(.album) {
            if let status = await request(.album) {
                list.append(status)
            }
        }
        if permissions.contains(.push) {
            if let status = await request(.push) {
                list.append(status)
            }
        }
        if permissions.contains(.tracking) {
            if let status = await request(.tracking) {
                list.append(status)
            }
        }
        if permissions.contains(.near) {
            if let status = await request(.near) {
                list.append(status)
            }
        }
        return list
    }

    func request(_ permission: Permissions) async -> Permissions? {
        switch permission {
        case .video, .camera:
            var stat = AVCaptureDevice.authorizationStatus(for: .video)
            if stat == .notDetermined {
                let granted = await AVCaptureDevice.requestAccess(for: .video)

                if granted {
                    stat = AVCaptureDevice.authorizationStatus(for: .video)
                }
            }

            if stat != .authorized {
                return permission
            } else {
                return nil
            }
        case .microphone, .audio:
            var stat = AVCaptureDevice.authorizationStatus(for: .audio)
            if stat == .notDetermined {
                let granted = await AVCaptureDevice.requestAccess(for: .audio)

                if granted {
                    stat = AVCaptureDevice.authorizationStatus(for: .audio)
                }
            }

            if stat != .authorized {
                return permission
            } else {
                return nil
            }
        case .photo, .album:
            var stat = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
            if stat == .notDetermined {
                stat = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
            }

            if stat != .authorized && stat != .limited {
                return permission
            } else {
                return nil
            }
        case .push:
            do {
                let options: UNAuthorizationOptions = [.alert, .badge, .sound]
                let granted: Bool = try await UNUserNotificationCenter.current().requestAuthorization(options: options)

                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                return granted ? nil : permission
            } catch {
                return permission
            }
        case .tracking:
            var stat = ATTrackingManager.trackingAuthorizationStatus
            if stat == .notDetermined {
                stat = await ATTrackingManager.requestTrackingAuthorization()
            }

            if stat != .authorized {
                return permission
            } else {
                return nil
            }
        case .near:
            print("### nearby-devices Requested ###")
            return nil
        }
    }
}
