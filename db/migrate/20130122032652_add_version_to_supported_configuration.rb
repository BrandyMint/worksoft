class AddVersionToSupportedConfiguration < ActiveRecord::Migration
  def change
    add_column :supported_configurations, :version_number, :integer, :limit => 8
  end
end
