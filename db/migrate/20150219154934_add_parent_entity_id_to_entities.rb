class AddParentEntityIdToEntities < ActiveRecord::Migration
  def change
    add_column :entities, :parent_entity_id, :integer
  end
end
