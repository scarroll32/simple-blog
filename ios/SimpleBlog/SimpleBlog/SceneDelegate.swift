import UIKit
import Turbo
import TurboNavigator
import Strada
import WebKit

let rootURL = URL(string: "http://localhost:3000")!

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    private lazy var navigator = TurboNavigator(delegate: self, pathConfiguration: pathConfiguration)

    private let pathConfiguration = PathConfiguration(sources: [
        .server(rootURL.appending(path: "turbo/ios/path_configuration.json"))
    ])

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        configureTurbo()
        window?.rootViewController = navigator.rootViewController
        navigator.route(rootURL) // Kick off our app!
    }
    
    private func configureTurbo() {
        // Add our component names to the user agent for Strada on the web.
        TurboConfig.shared.userAgent +=
            " \(Strada.userAgentSubstring(for: BridgeComponent.allTypes))"

        TurboConfig.shared.makeCustomWebView = { configuration in
            let webView = WKWebView(frame: .zero, configuration: configuration)
            Bridge.initialize(webView) // Initialize Strada.
            webView.isInspectable = true // Enable debugging in desktop Safari.
            return webView
        }
    }
}

extension SceneDelegate: TurboNavigationDelegate {
    // Always return our Strada-enabled controller.
    func handle(proposal: VisitProposal) -> ProposalResult {
        .acceptCustom(TurboWebViewController(url: proposal.url))
    }
}
