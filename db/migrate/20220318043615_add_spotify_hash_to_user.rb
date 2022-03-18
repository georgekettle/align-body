class AddSpotifyHashToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :spotify_hash, :jsonb
  end
end
