import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="drink-card"
export default class extends Controller {
  static values = {
    drinkVariantId: Number,
  }

  static targets = ["variant", "variantButton"]

  connect() {
    this.currentVariantId = this.drinkVariantIdValue
    this.switchVariant()
  }

  variantButtonClick(event) {
    this.currentVariantId = parseInt(event.target.dataset["variantId"])
    this.variantButtonTargets.forEach(element => {
      if (event.target != element) {
        element.classList.remove("bg-sky-200")
      } else {
        element.classList.add("bg-sky-200")
      }
    })
    this.switchVariant()
  }

  switchVariant() {
    this.variantTargets.forEach(element => {
      if (parseInt(element.dataset["variantId"]) !== this.currentVariantId) {
        element.style = "display: none;"
      } else {
        element.style = ""
      }
    })
  }
}
