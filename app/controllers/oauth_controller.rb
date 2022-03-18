class OauthController < ApplicationController
	skip_after_action :verify_authorized

	def spotify_login
		query_params = {
			client_id: ENV['SPOTIFY_CLIENT_ID'],
			response_type: 'code',
			redirect_uri: auth_spotify_url,
			# scope: 'user-read-email playlist-modify-public user-library-read user-library-modify',
			scope: 'ugc-image-upload user-read-playback-state user-modify-playback-state user-read-currently-playing user-read-private user-read-email user-follow-modify user-follow-read user-library-modify user-library-read streaming app-remote-control user-read-playback-position user-top-read user-read-recently-played playlist-modify-private playlist-read-collaborative playlist-read-private playlist-modify-public',
			show_dialog: true
		}
		url = "https://accounts.spotify.com/authorize/"
		redirect_to "#{url}?#{query_params.to_query}", allow_other_host: true
	end

	def spotify_callback
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    debugger
    redirect_to account_path, notice: 'Spotify successfully connected'
    # Now you can access user's private data, create playlists and much more

    # # Access private data
    # spotify_user.country #=> "US"
    # spotify_user.email   #=> "example@email.com"

    # # Create playlist in user's Spotify account
    # playlist = spotify_user.create_playlist!('my-awesome-playlist')

    # # Add tracks to a playlist in user's Spotify account
    # tracks = RSpotify::Track.search('Know')
    # playlist.add_tracks!(tracks)
    # playlist.tracks.first.name #=> "Somebody That I Used To Know"

    # # Access and modify user's music library
    # spotify_user.save_tracks!(tracks)
    # spotify_user.saved_tracks.size #=> 20
    # spotify_user.remove_tracks!(tracks)

    # albums = RSpotify::Album.search('launeddas')
    # spotify_user.save_albums!(albums)
    # spotify_user.saved_albums.size #=> 10
    # spotify_user.remove_albums!(albums)

    # # Use Spotify Follow features
    # spotify_user.follow(playlist)
    # spotify_user.follows?(artists)
    # spotify_user.unfollow(users)

    # # Get user's top played artists and tracks
    # spotify_user.top_artists #=> (Artist array)
    # spotify_user.top_tracks(time_range: 'short_term') #=> (Track array)

    # Check doc for more
  end
end
