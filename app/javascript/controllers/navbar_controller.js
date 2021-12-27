import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.initScrollEvent()
    this.toggleNavbarBackground()
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
