// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "helpers/cookies"
import * as Native from "helpers/native"
import "controllers"

document.addEventListener('turbo:load', (e) => {
	Native.hideSplashScreen()
})

document.addEventListener('turbo:before-fetch-request', Native.transitionOut)
document.addEventListener('turbo:before-render', Native.transitionIn)
