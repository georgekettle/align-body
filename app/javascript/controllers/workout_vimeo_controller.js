import { Controller } from "@hotwired/stimulus"
import * as Vimeo from "@vimeo/player"
import { v4 as uuidv4 } from 'uuid';
import * as recombee from 'recombee-js-api-client';

export default class extends Controller {
  static targets = ['embed']
  static values = {
    id: Number,
    recommId: String,
    userId: String,
    workoutId: String,
    recombeeId: String,
    recombeePublicToken: String,
    lastReportedPercent: {
      type: Number,
      default: 0
    }
  }

  initialize() {
    this.uuid = uuidv4()
    this.recommenderClient = new recombee.ApiClient(this.recombeeIdValue, this.recombeePublicTokenValue);
  }

  connect() {
    const options = {
      id: this.idValue,
      allowfullscreen: true
    }
    this.player = new Vimeo.default(this.embedTarget, options)

    this.initFullscreenListener()
    this.initProgressListener()
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

  initProgressListener() {
    this.player.on('progress', this.reportProgress.bind(this));
  }

  reportProgress(data) {
    const _this = this
    let progressDiff = Math.abs(data.percent - this.lastReportedPercentValue);
    if (progressDiff > 0.01) {
      const userId = `${this.userIdValue}`
      const itemId = `${this.workoutIdValue}`
      let options = {
        'sessionId': `${this.uuid}`,
        'cascadeCreate': true
      }
      this.hasRecommIdValue && (options.recommId = `${this.recommIdValue}`)
      this.recommenderClient.send(new recombee.SetViewPortion(userId, itemId, data.percent, options), () => {_this.lastReportedPercentValue = data.percent});
    }
  }
}