import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['menu']

  hide() {
    this.menuTarget.classList.add('hidden')
  }

  toggle(event) {
    event.preventDefault()
    // Prevent bubbling-up to the window, which will cause the hide() handler to fire.
    // Other solution could be the following:
    // if (this.element.contains(event.target) === false) { // hide the menu }
    // Where element represents the node where the controller is installed.
    event.stopPropagation()
    this.menuTarget.classList.toggle('hidden')
  }
}