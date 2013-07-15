class RemoveFileForUploadFromBeats < ActiveRecord::Migration
  def up
    remove_attachment :beats, :file_for_upload
  end

  def down
    add_attachment :beats, :file_for_upload
  end
end
