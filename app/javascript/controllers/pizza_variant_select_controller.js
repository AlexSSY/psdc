import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

// Connects to data-controller="pizza-variant-select"
export default class extends Controller {
  static values = { map: String, defaultKey: String }

  connect() {
    this.key = this.defaultKeyValue
    this.variantsMap = JSON.parse(this.mapValue)
  }

  async pizzaSizeSelectChange(event) {
    var pizzaSizeId = event.target.value
    this.key = this.replaceAt(this.key, 1, pizzaSizeId.toString())
    this._requestPartial()
  }

  doughButtonClick(event) {
    var pizzaDoughIdStr = event.target.dataset["doughId"]
    var pizzaDoughId = Number.parseInt(pizzaDoughIdStr)
    this.key = this.replaceAt(this.key, 2, pizzaDoughIdStr)
    this._requestPartial()
  }

  crustButtonClick(event) {
    var pizzaCrustIdStr = event.target.dataset["crustId"]
    var pizzaCrustId = Number.parseInt(pizzaCrustIdStr)
    this.key = this.replaceAt(this.key, 0, pizzaCrustIdStr)
    this._requestPartial()
  }

  _requestPartial() {
    var pizzaVariantId = this.variantsMap[this.key]
    get(`/pizza_variants/variant_partial/${pizzaVariantId}`, {
      responseKind: "turbo-stream"
    })
  }

  replaceAt(str, index, replacement) {
      return str.slice(0, index) + replacement + str.slice(index + replacement.length);
  }
}
