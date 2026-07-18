import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pizza-editor"
export default class extends Controller {
  static targets = [
    "form",
    "pizzaSizeInput",
    "pizzaCrustInput",
    "puzzaDoughInput",
    "ingredient"
  ]
  
  connect() {
  }
}
