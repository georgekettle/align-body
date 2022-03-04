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

export { isNative, hideSplashScreen, delay }