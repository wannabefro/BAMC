class AddSlugToUserBeat < ActiveRecord::Migration
  def change
    add_column :user_beats, :slug, :string, unique: true
  end
end
