import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pizza-filters"
export default class extends Controller {
  static targets = ['form']

  submitForm() {
    this.formTarget.requestSubmit()
  }
}
