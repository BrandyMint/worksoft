class RenameVersionToVersions < ActiveRecord::Migration
  def up
    add_column :supported_configurations, :versions, :string
    SupportedConfiguration.find_each do |bundle|
      bundle.update_column :versions, Version.new(bundle.version_number).to_s
    end

    remove_column :supported_configurations, :version_number
  end

  def down
    add_column :supported_configurations, :version_number, :integer
    remove_column :supported_configurations, :versions
  end
end
