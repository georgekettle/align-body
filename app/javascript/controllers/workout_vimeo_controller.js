import { Controller } from "@hotwired/stimulus"
import * as Vimeo from "@vimeo/player"

export default class extends Controller {
  static targets = ['embed', 'cover', 'detail']
  static values = {
    url: String,
  }

  connect() {
    const options = {
      id: this.urlValue,
      allowfullscreen: true,
      width: '100%'
    }
    this.player = new Vimeo.default(this.embedTarget, options)
    this.player.on('loaded', this.onLoad.bind(this))
  }

  disconnect() {
    this.player.destroy()
  }

  onLoad() {
    var frame = this.embedTarget.querySelector('iframe')
    if (frame !== null) {
      frame.style.width = '100%'
      frame.style.height = '100%'
    }
  }

  pause(e) {
    this.player.pause()
  }

  play(e) {
    this.player.play()
  }
}