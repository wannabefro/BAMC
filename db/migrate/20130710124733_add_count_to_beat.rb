class AddCountToBeat < ActiveRecord::Migration
  def change
    add_column :beats, :count, :integer, default: 0
  end
end
