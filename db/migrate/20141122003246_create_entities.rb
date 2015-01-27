class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :cached_long_name, :limit => 1024, :null => false
      t.string :display_name, :null => false
      t.string :name, :null => false
      t.string :contact_name # iRely Origin agcust_contact char(20)
      t.string :comments # iRely Origin agcust_comments char(30)
      t.integer :primary_location_id # <= Nullable for has_one relationship
      t.string :reference, :null => false # iRely Origin agcust_key char(10)
      # t.string :street_address, :null => false
      # t.string :city, :null => false
      # t.string :region, :null => false
      # t.string :region_code, :null => false
      # t.string :country, :null => false
      t.string :uuid, :limit => 32, :null => false

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
