class AddIsActiveToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :is_active, :integer, :default => 1, :null => false
  end
end
