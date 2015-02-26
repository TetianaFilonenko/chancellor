class AddIsActiveToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :is_active, :integer, :default => 1, :null => false
  end
end
