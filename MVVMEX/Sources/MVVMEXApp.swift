import SwiftUI
import CoordinatorFeatureInterface
import UIKit
import ProfileInterface

final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    static let container: DIContainer = .shared
    let coordinator: Coordinator = .init()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        AppDelegate.container.start(with: coordinator)
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let config = UISceneConfiguration(name: "Default Configuaration", sessionRole: connectingSceneSession.role)
        config.delegateClass = SceneDelegate.self
        return config
    }
}

final class SceneDelegate: NSObject, UIWindowSceneDelegate {

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("[App Scene] did becomeActive")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print("[App Scene] did background")
    }
}

@main
struct MVVMEXApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(delegate.coordinator)
        }
    }
}
