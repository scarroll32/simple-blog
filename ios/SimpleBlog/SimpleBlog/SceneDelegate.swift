import UIKit
import Turbo
import TurboNavigator

let rootURL = URL(string: "http://localhost:3000")!

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    private lazy var navigator = TurboNavigator(delegate: self, pathConfiguration: pathConfiguration)

    private let pathConfiguration = PathConfiguration(sources: [
        .server(rootURL.appending(path: "turbo/ios/path_configuration.json"))
    ])

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        window?.rootViewController = navigator.rootViewController
        navigator.route(rootURL) // Kick off our app!
    }
}

extension SceneDelegate: TurboNavigationDelegate {}
