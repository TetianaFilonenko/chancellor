class AddIsActiveToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_active, :integer, :default => 1
  end
end
