import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails"
import { isNative } from "helpers/native"

const delay = (ms) => {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default class extends Controller {
  connect() {
  	this.initPageTransitionListener()
  	this.initRemoveOpacityOnRender()
  }

  initPageTransitionListener() {
  	document.addEventListener('turbo:before-render', async (event) => {
		  event.preventDefault()

		  const content = document.getElementById('content')
		  content.classList.add('opacity-0', 'transition-opacity', 'duration-300', 'ease-out')
		  await delay(300)

		  event.detail.resume()
		})
  }

  initRemoveOpacityOnRender() {
    document.addEventListener('turbo:load', (e) => {
    	const content = document.getElementById('content')
    	const removalClasses = ['opacity-0', '-translate-x-1/2', 'translate-x-1/2']
    	removalClasses.forEach((cssClass) => {
    		content.classList.contains(cssClass) && content.classList.remove(cssClass)
    	})
    })
  }

  forwardAnimation(e) {
  	e.preventDefault()
  	const content = document.getElementById('content')
  	content.classList.add('transition-all', 'duration-300', '-translate-x-1/2', 'opacity-0', 'transform')
  	Turbo.visit(e.currentTarget.href)
  }

  backAnimation(e) {
  	e.preventDefault()
  	const content = document.getElementById('content')
  	content.classList.add('transition-all', 'duration-300', 'translate-x-1/2', 'opacity-0', 'transform')
  	Turbo.visit(e.currentTarget.href)
  }
}