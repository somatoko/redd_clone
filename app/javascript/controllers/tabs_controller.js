import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "text", "url", "media"]

  connect() {
    this._showActiveTab(this.buttonTargets[0].dataset.tabId)
    
  }

  toggle(event) {
    event.preventDefault()
    const tabId = event.target.dataset.tabId
    this._showActiveTab(tabId)
    if (tabId === 'text') {
      this.textTarget.classList.remove('hidden')
      this.urlTarget.classList.add('hidden')
      this.mediaTarget.classList.add('hidden')
    }
    else if (tabId === 'url') {
      this.textTarget.classList.add('hidden')
      this.urlTarget.classList.remove('hidden')
      this.mediaTarget.classList.add('hidden')
    }
    else if (tabId === 'media') {
      this.textTarget.classList.add('hidden')
      this.urlTarget.classList.add('hidden')
      this.mediaTarget.classList.remove('hidden')
    }
  }

  _showActiveTab(tabId) {
    this.buttonTargets.forEach( btn => {
      if (tabId == btn.dataset.tabId) {
        btn.classList.add('bg-indigo-50')
      } else {
        btn.classList.remove('bg-indigo-50')
      }
    })
  }
}