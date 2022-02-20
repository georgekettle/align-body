import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
	static targets = ['recaptcha']

  showRecaptcha() {
  	this.recaptchaTarget.classList.remove('h-0')
  	this.recaptchaTarget.classList.add('opacity-100')
  }
}