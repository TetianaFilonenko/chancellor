class CreateDefaultLocations < ActiveRecord::Migration
  def change
    create_table :default_locations do |t|
      t.references :entity, :null => false, :polymorphic => true, :index => true
      t.references :location, :null => false

      t.datetime :deleted_at
      t.timestamps
    end

    add_index :default_locations,
              [:entity_id, :entity_type, :location_id],
              :name => :ix_default_locations_entity_type_location,
              :unique => true
  end
end
