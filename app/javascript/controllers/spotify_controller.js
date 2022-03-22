import { Controller } from "@hotwired/stimulus"
import SpotifyWebApi from 'spotify-web-api-js'

export default class extends Controller {
	static targets = ['controls', 'play', 'pause', 'skipNext', 'skipPrev', 'volume', 'open', 'playlist', 'loading', 'image', 'trackInfo', 'trackTitle', 'trackArtist']
	static values = {
		token: String,
		deviceId: String,
		volume: {
			type: Number,
			default: 10
		}
	}

  connect() {
  	this.initSpotifyWebApi()
  	window.onSpotifyWebPlaybackSDKReady = this.initPlayer.bind(this);
		this.insertSpotifyPlaybackScript()
  }

  disconnect() {
  	// this.disconnectSpotifyWebApi()
  	this.removePlayerListeners()
  	window.onSpotifyWebPlaybackSDKReady = null;
  	this.removeSpotifyPlaybackScript()
  }

  insertSpotifyPlaybackScript() {
		this.script = document.createElement('script');
		this.script.src = "https://sdk.scdn.co/spotify-player.js";
		document.body.appendChild(this.script);
	}

	removeSpotifyPlaybackScript() {
		this.script.remove()
	}

  async initPlayer() {
  	const { Player } = window.Spotify
  	this.player = new Player({
	    name: "Align Body",
	    volume: this.volumeValue / 100,
	    getOAuthToken: callback => { callback(this.tokenValue); }
	  });
	  this.initPlayerListeners()
	  this.player.connect()
  }

  initSpotifyWebApi() {
		this.spotifyWebApi = new SpotifyWebApi()
		this.spotifyWebApi.setAccessToken(this.tokenValue)
		this.spotifyWebApi.getMe()
			.then(data => console.log(data))
			.catch(error => console.log(error))
	}

	initPlayerListeners() {
		this.player.addListener("player_state_changed", this.afterStateChange.bind(this));

		// // Ready
	  this.player.addListener('ready', ({ device_id }) => {
	  	this.deviceIdValue = device_id
	  	// set device as 'Align Body'
	    this.spotifyWebApi.transferMyPlayback([device_id], {play: false}, () => {
	    	console.log('Ready with Device ID', device_id);
	    })
	  });

	  // Not Ready
	  this.player.addListener('not_ready', ({ device_id }) => {
	    console.log('Device ID has gone offline', device_id);
	  });

	  // errors
	  this.player.addListener('initialization_error', ({ message }) => { 
	    console.error(message);
	  });

	  this.player.addListener('authentication_error', ({ message }) => {
	      console.error(message);
	  });

	  this.player.addListener('account_error', ({ message }) => {
	      console.error(message);
	  });
	}

	setLoadingState() {
		this.loadingTargets.forEach((loading) => {
			loading.classList.remove('hidden')
		})
		this.imageTarget.classList.add('hidden')
		this.trackInfoTarget.classList.add('hidden')
		// add disabled
		this.playTarget.disabled = true
		this.pauseTarget.disabled = true
		this.skipNextTarget.disabled = true
		this.skipPrevTarget.disabled = true
		// add disabled cursor to controls
		this.controlsTarget.classList.add('cursor-not-allowed')
	}

	removeLoadingState() {
		this.loadingTargets.forEach((loading) => {
			loading.classList.add('hidden')
		})
		this.imageTarget.classList.remove('hidden')
		this.trackInfoTarget.classList.remove('hidden')
		// remove disabled
		this.playTarget.disabled = false
		this.pauseTarget.disabled = false
		this.skipNextTarget.disabled = false
		this.skipPrevTarget.disabled = false
		// add disabled cursor to controls
		this.controlsTarget.classList.remove('cursor-not-allowed')
	}

	afterStateChange(state) {
		console.log(state)
		this.setPlayingState(state)
		if (state && state.loading) {
			this.setLoadingState()
		} else {
			this.setTrackData(state)
			this.removeLoadingState()
		}
	}

	setTrackData(state) {
		const currentTrack = state.track_window.current_track
		if (currentTrack) {
			this.imageTarget.src = currentTrack.album.images[1].url
			this.trackTitleTarget.innerHTML = currentTrack.name
			this.trackArtistTarget.innerHTML = currentTrack.artists[0].name
		}
	}

	setPlayingState(state) {
		if (state && state.paused) {
			this.pauseTarget.classList.add('hidden')
			this.playTarget.classList.remove('hidden')
		} else {
			this.playTarget.classList.add('hidden')
			this.pauseTarget.classList.remove('hidden')
		}
	}

	removePlayerListeners() {
		if (this.player) {
			const _this = this
			const listeners = Object.keys(this.player._eventListeners)
			listeners.forEach((listener) => {
				_this.player.removeListener(listener)
			})
		}
	}

	play() {
		this.player.togglePlay()
		this.playTarget.classList.add('hidden')
		this.pauseTarget.classList.remove('hidden')
	}

	pause() {
		this.player.pause()
		this.pauseTarget.classList.add('hidden')
		this.playTarget.classList.remove('hidden')
	}

	playNext() {
		this.spotifyWebApi.skipToNext({devide_id: this.deviceId}, () => {
			console.log('skipped to next')
		})
		this.setLoadingState()
	}

	playPrev() {
		this.spotifyWebApi.skipToPrevious({devide_id: this.deviceId}, () => {
			console.log('skipped to prev')
		})
		this.setLoadingState()
	}

	changeVolume(e) {
		e.preventDefault()
		const max = parseInt(e.currentTarget.max, 10)
		const value = parseInt(e.currentTarget.value, 10)
		const volume = parseInt((value / max) * 100, 10)
		this.spotifyWebApi.setVolume(volume, { device_id: this.deviceIdValue }, () => {
			this.volumeValue = volume
		})
	}

	playPlaylist(e) {
		e.preventDefault()
		this.spotifyWebApi.play({
			device_id: this.deviceIdValue,
			context_uri: e.currentTarget.dataset.playlistUri
		})
	}

	showPlaylist(e) {
		e.preventDefault()
		this.openTarget.classList.add('hidden')
		this.playlistTarget.classList.remove('hidden')
	}

	closePlaylist(e) {
		e.preventDefault()
		this.openTarget.classList.remove('hidden')
		this.playlistTarget.classList.add('hidden')
	}
}