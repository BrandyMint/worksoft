class ChangeVersionsToBigInt < ActiveRecord::Migration
  def up
    remove_column :user_systems, :user_id
    change_column :bundles, :version_number, :bigint
    change_column :user_systems, :kernel_version_number, :bigint
    change_column :user_systems, :configuration_version_number, :bigint
  end

  def down
    add_column :user_systems, :user_id, :integer
    change_column :bundles, :version_number, :bigint
    change_column :user_systems, :kernel_version_number, :bigint
    change_column :user_systems, :configuration_version_number, :bigint
  end
end
