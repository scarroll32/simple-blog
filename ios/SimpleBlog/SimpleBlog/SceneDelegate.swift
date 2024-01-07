import UIKit
import Turbo

let rootURL = URL(string: "http://localhost:3000")!

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    private let navigationController = UINavigationController()
    private let session = Session()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        window?.rootViewController = navigationController
        TurboLog.debugLoggingEnabled = true
        self.session.delegate = self
        
        let proposal = VisitProposal(url: rootURL, options: VisitOptions())
        visit(proposal: proposal)
    }
    
    private func visit(proposal: VisitProposal){
        let visitable = VisitableViewController(url: proposal.url)
        navigationController.pushViewController(visitable, animated: true)
        session.visit(visitable)
    }
}

extension SceneDelegate: SessionDelegate {
    func session(_ session: Turbo.Session, didFailRequestForVisitable visitable: Turbo.Visitable, error: Error) {
        print("Failed to visit page: \(error.localizedDescription)")
    }
    
    func session(_ session: Turbo.Session, didProposeVisit proposal: Turbo.VisitProposal) {
        visit(proposal: proposal)
    }
    
    func sessionWebViewProcessDidTerminate(_ session: Turbo.Session) {
        session.reload()
    }
    
}
