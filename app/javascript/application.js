// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import Turn from "helpers/turn"
Turn.start()
import "helpers/cookies"
import * as Native from "helpers/native"
import "controllers"

document.addEventListener('turbo:load', (e) => {
	Native.hideSplashScreen()
})
