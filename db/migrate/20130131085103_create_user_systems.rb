class CreateUserSystems < ActiveRecord::Migration
  def change
    create_table :user_systems do |t|
      t.integer :user_id, :null => false
      t.string :name
      t.integer :kernel_version_number, :null => false
      t.integer :configuration_id
      t.integer :configuration_version_number

      t.timestamps
    end

    add_index :user_systems, :user_id
  end
end
