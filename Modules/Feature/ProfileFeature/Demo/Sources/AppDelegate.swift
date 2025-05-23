import UIKit
import SwiftUI

import ProfileInterface
import ProfileFeature
import ProfileDomainTesting
import ProfileTesting


final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let config = UISceneConfiguration(name: "Default Configuaration", sessionRole: connectingSceneSession.role)
        config.delegateClass = SceneDelegate.self
        return config
    }
}

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
    var window: UIWindow?

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("[Scene] did becomeActive")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print("[Scene] did background")
    }
}
