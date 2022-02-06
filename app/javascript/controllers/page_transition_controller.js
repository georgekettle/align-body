import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"

const delay = (ms) => {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default class extends Controller {
  connect() {
  	this.initPageTransitionListener()
  	// this.initVisitListener()
  }

  initPageTransitionListener() {
  	document.addEventListener('turbo:before-render', async (event) => {
		  event.preventDefault()

		  document.body.classList.add('opacity-0', 'transition-opacity', 'duration-300', 'ease-out')
		  // event.detail.newBody.classList.add('opacity-0')
		  await delay(300)

		  event.detail.resume()
		})
  }

  forwardAnimation(e) {
  	e.preventDefault()
  	document.body.classList.add('transition-all', 'duration-300', '-translate-x-1/2', 'opacity-0', 'transform')
  	Turbo.visit(e.currentTarget.href, { action: 'advance' })
  }

  backAnimation(e) {
  	e.preventDefault()
  	document.body.classList.add('transition-all', 'duration-300', 'translate-x-1/2', 'opacity-0', 'transform')
  	Turbo.visit(e.currentTarget.href, { action: 'advance' })
  }
}