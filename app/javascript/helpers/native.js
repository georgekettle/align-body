import { getCookie } from 'helpers/cookies'

const delay = (ms) => {
  return new Promise(resolve => setTimeout(resolve, ms));
}

const isNative = () => {
	return !!getCookie('is_native')
}

const hideSplashScreen = () => {
	if (window.ReactNativeWebView) {
  	window.ReactNativeWebView.postMessage(
  			JSON.stringify({
	        type: 'hideSplashScreen'
	      })
  		);
  }
}

const hideLoader = (event) => {
  const loader = event.detail.newBody.querySelector('#transition-loader')
  loader.classList.add('hidden')
  loader.classList.remove('opacity-100')
}

const showLoader = async () => {
  const loader = document.getElementById('transition-loader')
  loader.classList.remove('hidden')
  loader.classList.add('opacity-100')
}

const hideMainContent = async () => {
	const content = document.getElementById('content')
	content.classList.add('opacity-0', 'transition-opacity', 'duration-100', 'ease-out')
  await delay(100)
}

const transitionIn = async (event) => {
  event.preventDefault()
	hideLoader(event)
  event.detail.resume()
}

const transitionOut = async (event) => {
  event.preventDefault()
  if (event.detail.fetchOptions.method === "GET") {
  	await hideMainContent()
	  await showLoader()
  }
  event.detail.resume()
}

export { isNative, hideSplashScreen, transitionOut, transitionIn }