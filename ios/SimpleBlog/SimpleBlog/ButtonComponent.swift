import Strada
import UIKit

// A Strada component to add a native button to the upper right of the navigation.
final class ButtonComponent: BridgeComponent {
    override class var name: String { "button" }

    override func onReceive(message: Message) {
        // Currently the only event but good practice to check.
        if message.event == "connect" {
            addButton(message: message)
        }
    }

    private var viewController: UIViewController? {
        delegate.destination as? UIViewController
    }

    private func addButton(message: Message) {
        // Parse the JSON from the Strada message, otherwise no-op.
        guard let data: MessageData = message.data(), let viewController else { return }

        let action = UIAction(title: data.title) { _ in
            // When tapped, tell the bridge.
            self.reply(to: "connect")
        }

        // Add the native button!
        viewController.navigationItem.rightBarButtonItem =
            UIBarButtonItem(primaryAction: action)
    }
}

// Expected format of the received Strada JSON message:
// {"title": "Save"}
extension ButtonComponent {
    struct MessageData: Decodable {
        let title: String
    }
}
