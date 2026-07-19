import { Controller } from "@hotwired/stimulus"
import { createPopper } from "@popperjs/core"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["button", "menu"]

  toggle(event) {
    this.menuTarget.classList.toggle("hidden");
  }
}
