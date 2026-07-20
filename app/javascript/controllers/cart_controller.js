import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cart"
export default class extends Controller {
  static targets = ['background']

  connect() {}

  close() {
    this.backgroundTarget.remove()
  }
}
