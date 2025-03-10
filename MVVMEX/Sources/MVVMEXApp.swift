import SwiftUI
import UIKit

import AppConfigDomain
import ProfileInterface

//@main
final class AppDelegate: UIResponder, UIApplicationDelegate, ObservableObject {
    @Published var key: UUID = .init()

    static let container: DIContainer = .shared
    var coordinator: Coordinator = .init()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        AppDelegate.container.start(with: coordinator)
        return true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Scene Configuration", sessionRole: connectingSceneSession.role)
//        config.delegateClass = SceneDelegate.self
//        return config
    }

    func restart() {
//        coordinator = Coordinator()
        key = .init()
    }
}

final class SceneDelegate: UIResponder, UIWindowSceneDelegate, ObservableObject {
    var window: UIWindow?

    func restart() {
        makeAppFlowCoordinator(isLogout: true)
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        window = UIWindow(windowScene: windowScene)

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let rootView = factoryContentView(appDelegate)

        window?.rootViewController = UIHostingController(rootView: rootView)

        window?.makeKeyAndVisible()
    }
    func sceneDidBecomeActive(_ scene: UIScene) {
        print("[App Scene] did becomeActive")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print("[App Scene] did background")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        print("[App Scene] Will Foreground")
    }

    func makeAppFlowCoordinator(isLogout: Bool = false) {
        self.window?.rootViewController = nil

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let rootView = factoryContentView(appDelegate)

        self.window?.rootViewController = UIHostingController(rootView: rootView)
    }

    func factoryContentView(_ delegate: AppDelegate) -> some View {
        delegate.restart()

        return ContentView()
            .environmentObject(delegate.coordinator)
            .id(delegate.key)
    }
}

/// 여기서 재시작 못하나
/// 재시작 때문에 @main을 AppDelegate로 옮겨서 미사용.... ㅜ
/// SwiftUI.App 에서 @main을 쓰면
/// - UIApplication.shared.delegate as? AppDelegate
/// - UIApplication.shared.connectedScenes.first(where: {$0 is UIWindowScene})?.delegate as? SceneDelegate
/// 를 찾지 못하고 SwiftUI.AppDelegate, SwiftUI.AppSceneDelegate로 찾아서 위에 언급한 두 클래스로 타입캐스팅이 불가능? 아직 방법 찾지 못했다.
@main
struct MVVMEXApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @Environment(\.scenePhase) private var scenePhase

    @State private var isIntro = true

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(delegate.coordinator)
                .id(delegate.key)
        }
    }
}
