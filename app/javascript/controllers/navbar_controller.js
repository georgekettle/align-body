import { Controller } from "@hotwired/stimulus"
import { isNative } from "../helpers/native.js"

export default class extends Controller {
  static values = {
    context: String
  }
  
  connect() {
    if (!isNative()) {
      this.initScrollEvent()
      this.toggleNavbarBackground()
    }
  }
  
  initScrollEvent() {
  	const _this = this
  	window.addEventListener('scroll', (e) => {
  		_this.toggleNavbarBackground()
  	})
  }

  toggleNavbarBackground() {
  	const navbar = this.element
  	if (window.pageYOffset >= 50) {
			navbar.classList.add('bg-white/95', 'backdrop-blur-md')
		} else {
			navbar.classList.remove('bg-white/95', 'backdrop-blur-md')
		}
  }
}
