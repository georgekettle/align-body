// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "helpers/cookies"
import "helpers/native"
import "controllers"

document.addEventListener('turbo:load', (e) => {
	if (window.ReactNativeWebView) {
  	window.ReactNativeWebView.postMessage(
  			JSON.stringify({
	        type: 'hideSplashScreen'
	      })
  		);
  }
})