import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="switcher"
export default class extends Controller {
  static targets = ['button']

  connect() {
  }

  buttonClick(event) {
    this.buttonTargets.forEach(button => {
      if (button == event.target) {
        button.classList.add('bg-sky-200')
      } else {
        button.classList.remove('bg-sky-200')
      }
    });  
  }
}
