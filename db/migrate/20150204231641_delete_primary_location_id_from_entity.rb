class DeletePrimaryLocationIdFromEntity < ActiveRecord::Migration
  def change
    remove_column :entities, :primary_location_id
  end
end
