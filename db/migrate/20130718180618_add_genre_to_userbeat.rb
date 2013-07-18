class AddGenreToUserbeat < ActiveRecord::Migration
  def change
    add_column :user_beats, :genre, :string
    add_column :user_beats, :name, :string
    add_column :user_beats, :state, :string, default: 'public'
  end
end
