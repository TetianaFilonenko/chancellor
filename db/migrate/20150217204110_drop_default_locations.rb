class DropDefaultLocations < ActiveRecord::Migration
  def change
    drop_table :default_locations
  end
end
