import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pizza-filters"
export default class extends Controller {
  static targets = ['form']

  submitForm() {
    this.formTarget.querySelectorAll("select").forEach((select) => {
      if (select.value === "") {
        select.dataset.name = select.name
        select.removeAttribute("name")
      }
    })

    this.formTarget.requestSubmit()

    this.formTarget.querySelectorAll("select[data-name]").forEach((select) => {
      select.name = select.dataset.name
      delete select.dataset.name
    })
  }
}
