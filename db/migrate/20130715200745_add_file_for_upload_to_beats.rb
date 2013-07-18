class AddFileForUploadToBeats < ActiveRecord::Migration
  def up
   add_attachment :beats, :file_for_upload 
  end

  def down
    remove_attachment :beats, :file_for_upload
  end
end
