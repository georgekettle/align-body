import { getCookie } from './cookies.js'

const isNative = () => {
	return !!getCookie('is_native')
}

export { isNative }