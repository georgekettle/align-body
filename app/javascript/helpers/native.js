import { getCookie } from 'helpers/cookies'

const isNative = () => {
	return !!getCookie('is_native')
}

export { isNative }