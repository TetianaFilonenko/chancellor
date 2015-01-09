class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.references :user, :null => false
      t.string :name, :limit => 32, :null => false

      t.timestamps
    end
  end
end
