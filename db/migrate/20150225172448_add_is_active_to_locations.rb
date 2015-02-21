class AddIsActiveToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :is_active, :integer, :default => 1, :null => false
  end
end
