import * as Native from "./native"

const showLoader = async (e) => {
	const loader = document.querySelector('#transition-loader')
	await Native.delay(1000)
	loader.classList.remove('opacity-0')
}

const hideLoader = async (e) => {
	e.preventDefault()
	const loader = e.detail.newBody.querySelector('#transition-loader')
	loader.classList.add('opacity-0')
	e.detail.resume()
}

document.addEventListener('turbo:visit', showLoader)
document.addEventListener('turbo:before-render', hideLoader)