import { Controller } from "@hotwired/stimulus"
import { isNative } from "helpers/native"

export default class extends Controller {
	static targets = ['spacerTop', 'spacerBottom']

  connect() {
  	if (isNative()) {
	  	if (window.insets) {
	  		// apply already exisiting insets
	  		this.applySafeAreaInsets(window.insets)
	  	} else {
	  		// listen for insets, save to window.insets and apply
	  		this.listenForInsets()
	  		this.askNativeToSendInsets() // necessary for first load
	  	}
  	}
  }

  askNativeToSendInsets() {
  	if (window.ReactNativeWebView) {
    	window.ReactNativeWebView.postMessage(
    			JSON.stringify({
		        type: 'sendInsets',
		      })
    		);
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
}