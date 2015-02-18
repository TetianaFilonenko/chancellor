class AddDefaultLocationIdAndIsActiveToSalesperson < ActiveRecord::Migration
  def change
    add_column :salespeople, :default_location_id, :integer
    add_column :salespeople, :is_active, :integer, :default => 1, :null => false
  end
end
