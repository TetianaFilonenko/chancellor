class AddIsActiveToUser < ActiveRecord::Migration
  def change
    # Integer for boolean values since booleans are just stupid
    # activerecord/lib/active_record/connection_adapters/abstract/schema_definitions.rb:10:      
    # TRUE_VALUES = [true, 1, '1', 't', 'T', 'true', 'TRUE'].to_set
    # ...Seriously!?
    add_column :users, :is_active, :integer, :default => 1
  end
end
