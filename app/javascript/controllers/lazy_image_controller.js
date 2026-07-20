import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="lazy-image"
export default class extends Controller {
  static targets = ["placeholder", "image"]

  connect() {
    if (this.imageTarget.complete) {
      this.loaded()
    }
  }

  loaded() {
    this.placeholderTarget.classList.add("hidden")
    this.imageTarget.classList.remove("opacity-0")
  }
}
