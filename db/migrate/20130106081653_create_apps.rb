class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name, :null => false
      t.string :state, :null => false, :default => 'new'
      t.integer :developer_profile_id, :null => false

      t.timestamps
    end

    add_index :apps, :name, :unique => true

    Bundle.destroy_all

    remove_column :bundles, :name
    add_column :bundles, :app_id, :integer, :null => false

    add_index :bundles, :app_id

    add_index :bundles, [:app_id, :version], :unique => true
  end
end
