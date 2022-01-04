import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
	static targets = ['spacerTop', 'spacerBottom']

  connect() {
  	if (window.insets) {
  		// apply already exisiting insets
  		this.applySafeAreaInsets(window.insets)
  	} else {
  		this.listenForInsets()
  	}
  }

  listenForInsets() {
  	const _this = this
		window.addEventListener("message", (event)=>{
			const data = JSON.parse(event.data)
			if (data && data["type"] === 'expo:safe-area-insets') {
				window.insets = data["insets"]
				_this.applySafeAreaInsets(window.insets)
			}
		})
	}

	applySafeAreaInsets = (insets) => {
		const _this = this
		this.spacerTopTargets.forEach((spacerTop) => {
  		spacerTop.style.height = `${insets["top"]}px`
  	})
  	this.spacerBottomTargets.forEach((spacerBottom) => {
  		spacerBottom.style.height = `${insets["bottom"]}px`
  	})
	}

	// spacerTopTargetConnected(elem) {
	// 	elem.style.height = `${window.insets["top"]}px`
	// }
}