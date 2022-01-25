import { getCookie } from './cookies'

const isNative = () => {
	return !!getCookie('is_native')
}

export { isNative }