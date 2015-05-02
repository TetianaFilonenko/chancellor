class CreateChancellorEntities < ActiveRecord::Migration
  def change
    create_table :chancellor_entities do |t|
      t.string :cached_long_name, :limit => 1024, :null => false
      t.string :display_name, :null => false
      t.integer :is_active, :default => 1, :null => false
      t.string :name, :null => false
      t.integer :parent_entity_id
      t.string :reference, :null => false
      t.string :uuid, :limit => 32, :null => false

      t.datetime :deleted_at
      t.timestamps :null => false
    end
  end
end
