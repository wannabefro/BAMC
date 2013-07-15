class AddAttachmentToUserBeat < ActiveRecord::Migration
  def up
    add_attachment :user_beats, :beat
  end

  def down
    remove_attachment :user_beats, :beat
  end
end
