import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
	static targets = ['tab']

  tabTargetConnected(element) {
  	const _this = this

  	const currentURL = `${location.protocol}//${location.host}${location.pathname}`

  	if (element.href === currentURL) {
  		this.makeTabActive(element)
  	}

  	element.addEventListener('click', (e) => {
  		const clickedTab = e.currentTarget
  		_this.tabTargets.forEach((tab) => {
  			if (tab === clickedTab) {
  				this.makeTabActive(tab)
  			} else {
  				this.makeTabInactive(tab)
  			}
  		})
  	})
  }

  makeTabActive(element) {
    element.classList.add('border-t-2')
  }

  makeTabInactive(element) {
		element.classList.remove('border-t-2')
  }
}