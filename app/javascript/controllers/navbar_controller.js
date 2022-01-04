import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    context: String
  }
  
  connect() {
    if (this.contextValue === 'web') {
      this.initScrollEvent()
      this.toggleNavbarBackground()
      window.isNative && this.hide()
    } else if (this.contextValue === 'native') {
      !window.isNative && this.hide()
    }
  }

  hide() {
    this.element.classList.add("hidden")
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
