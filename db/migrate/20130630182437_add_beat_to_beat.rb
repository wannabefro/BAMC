class AddBeatToBeat < ActiveRecord::Migration
  def change
    add_attachment :beats, :beat
  end
end
