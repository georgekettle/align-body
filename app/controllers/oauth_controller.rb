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
    current_user.update_attribute('spotify_hash', spotify_user.to_hash)
    redirect_to account_path, notice: 'Spotify successfully connected'
  end

  def spotify_disconnect
    if current_user.update(spotify_hash: nil)
      redirect_to account_path, notice: 'Spotify successfully disconnected'
    else
      redirect_to account_path, alert: 'Oops, something went wrong...'
    end
  end
end
