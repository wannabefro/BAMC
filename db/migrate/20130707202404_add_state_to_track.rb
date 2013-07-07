class AddStateToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :state, :string, default: 'public'
  end
end
