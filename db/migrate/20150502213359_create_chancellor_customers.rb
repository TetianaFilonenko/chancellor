class CreateChancellorCustomers < ActiveRecord::Migration
  def change
    create_table :chancellor_customers do |t|
      t.references :default_contact
      t.references :default_location
      t.references :entity, :null => false
      t.references :parent_customer
      t.string :reference, :null => false
      t.references :salesperson
      t.integer :is_active, :default => 1, :null => false
      t.string :uuid, :limit => 32, :null => false

      t.datetime :deleted_at
      t.timestamps :null => false
    end
  end
end
