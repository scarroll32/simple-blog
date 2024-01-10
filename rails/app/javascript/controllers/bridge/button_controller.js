import { BridgeComponent } from "@hotwired/strada"
import { BridgeElement } from "@hotwired/strada"

export default class extends BridgeComponent {
  static component = "button"

  connect() {
    super.connect()

    const button = this.bridgeElement
    const title = button.title

    this.send("connect", {title}, () => {
      button.click()
    })
  }
}
