import { Controller } from "@hotwired/stimulus"
import * as Vimeo from "@vimeo/player"

export default class extends Controller {
  static targets = ['embed']
  static values = {
    id: Number
  }

  connect() {
    const options = {
      id: this.idValue,
      allowfullscreen: true
    }
    this.player = new Vimeo.default(this.embedTarget, options)

    this.initFullscreenListener()
  }

  disconnect() {
    this.player.destroy()
  }

  initFullscreenListener() {
    const embed = this.embedTarget
    this.player.on('fullscreenchange', (e) => {
      e.fullscreen ? embed.classList.remove('hidden') : embed.classList.add('hidden')
    })
  }

  fullscreen(e) {
    e.preventDefault()
    this.player.requestFullscreen()
  }
}