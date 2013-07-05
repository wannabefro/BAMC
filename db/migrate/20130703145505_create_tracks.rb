class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :beat_id, null: false
      t.integer :user_id, null: false
      t.string :name
      t.string :track, null: false

      t.timestamps
    end
  end
end
