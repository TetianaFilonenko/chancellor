class CreateSalespeople < ActiveRecord::Migration
  def change
    create_table :salespeople do |t|
      t.references :entity, :null => false
      t.string :gender, :limit => 7
      t.references :location
      t.string :phone
      t.string :reference, :null => false
      t.string :uuid, :limit => 32, :null => false

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
