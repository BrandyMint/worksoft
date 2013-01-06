class CreateDeveloperProfiles < ActiveRecord::Migration
  def change
    create_table :developer_profiles do |t|
      t.string :name, :null => false
      t.string :avatar
      t.integer :apps_count, :null => false, :default => 0

      t.timestamps
    end

    add_column :users, :developer_profile_id, :integer

    add_index :users, :developer_profile_id

    add_index :developer_profiles, :name, :unique => true
    add_index :developer_profiles, :apps_count
  end
end
