class AddTrackToTracks < ActiveRecord::Migration
  def change
    add_attachment :tracks, :track
  end
end
