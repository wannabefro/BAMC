class AddStateToBeat < ActiveRecord::Migration
  def change
    add_column :beats, :state, :string, default: 'pending'
  end
end
