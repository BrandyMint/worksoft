class AddActiveBundleIdToApps < ActiveRecord::Migration
  def up
    add_column :apps, :active_bundle_id, :integer
    remove_column :bundles, :version
    add_column :bundles, :version, :integer, :limit => 8, :null => false, :default => Versionub.parse('0.1.0').to_numeric
    add_index :bundles, [:app_id, :version], :unique => true
  end

  def down
    remove_column :apps, :active_bundle_id
    change_column :bundles, :version, :string
  end
end
