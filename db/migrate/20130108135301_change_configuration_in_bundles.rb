class ChangeConfigurationInBundles < ActiveRecord::Migration
  def up
    remove_column :bundles, :nameconf
    remove_column :bundles, :versionconf
    remove_column :bundles, :version1c

    add_column :bundles, :supported_configurations, :text #, :array => true#, :null => false
    add_column :bundles, :supported_kernel_versions, :text #, :array => true#, :null => false
  end

  def down
    add_column :bundles, :nameconf, :string
    add_column :bundles, :versionconf, :string
    add_column :bundles, :version1c, :string

    remove_column :bundles, :supported_configurations
    remove_column :bundles, :supported_kernel_versions
  end
end
