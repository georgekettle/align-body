import { getCookie } from 'helpers/cookies'

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

export { isNative }