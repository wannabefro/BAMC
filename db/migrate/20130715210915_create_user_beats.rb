class CreateUserBeats < ActiveRecord::Migration
  def change
    create_table :user_beats do |t|

      t.timestamps
    end
  end
end
