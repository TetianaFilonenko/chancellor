class CreateChancellorSalespeople < ActiveRecord::Migration
  def change
    create_table :chancellor_salespeople do |t|
      t.references :entity, :null => false
      t.string :gender, :limit => 7
      t.integer :is_active, :default => 1, :null => false
      t.references :default_location
      t.string :phone
      t.string :reference, :null => false
      t.string :uuid, :limit => 32, :null => false

      t.datetime :deleted_at
      t.timestamps :null => false
    end
  end
end
