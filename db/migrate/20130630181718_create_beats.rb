class CreateBeats < ActiveRecord::Migration
  def change
    create_table :beats do |t|
      t.decimal :price, :precision => 3, :scale => 2, default: 0.99
      t.string :name, null: false
      t.string :beat_url, null: false
      t.string :genre, null: false

      t.timestamps
    end
  end
end
