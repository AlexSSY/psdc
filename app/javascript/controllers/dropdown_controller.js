import { Controller } from "@hotwired/stimulus"
import { createPopper } from "@popperjs/core"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["button", "menu"]

  toggle(event) {
    // this.menuTarget.classList.toggle("hidden");
  }

  connect() {
    this.popper = createPopper(
      this.buttonTarget,
      this.menuTarget,
      {
        placement: "bottom-start",
        modifiers: [
          {
            name: "offset",
            options: {
              offset: [0, 8]
            }
          },
          {
            name: "flip"
          },
          {
            name: "preventOverflow"
          }
        ]
      }
    )

    this.clickOutside = this.clickOutside.bind(this)

    this.escape = (event) => {
      if (event.key === "Escape") {
        this.close()
      }
    }

    document.addEventListener("keydown", this.escape)

    this.onAnotherDropdownOpened = (event) => {
      if (event.detail.controller !== this) {
        this.close()
      }
    }

    document.addEventListener(
      "dropdown:open",
      this.onAnotherDropdownOpened
    )
  }

  disconnect() {
    document.removeEventListener("click", this.clickOutside)
    document.removeEventListener("keydown", this.escape)
    document.removeEventListener(
      "dropdown:open",
      this.onAnotherDropdownOpened
    )
    this.popper.destroy()
  }

  toggle(event) {
    event.stopPropagation()

    if (this.menuTarget.classList.contains("hidden")) {
      this.open()
    } else {
      this.close()
    }
  }

  open() {
    document.dispatchEvent(new CustomEvent("dropdown:open", {
      detail: { controller: this }
    }))
  
    this.menuTarget.classList.remove("hidden")
    this.popper.update()

    document.addEventListener("click", this.clickOutside)
  }

  close() {
    this.menuTarget.classList.add("hidden")

    document.removeEventListener("click", this.clickOutside)
  }

  clickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.close()
    }
  }
}
