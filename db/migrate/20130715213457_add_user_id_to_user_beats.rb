class AddUserIdToUserBeats < ActiveRecord::Migration
  def up 
    add_column :user_beats, :user_id, :integer
  end

  def down
    remove_column :user_beats, :user_id
  end
end
