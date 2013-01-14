class RenameVersionInBundles < ActiveRecord::Migration
  def up
    rename_column :bundles, :version, :version_number
  end

  def down
    rename_column :bundles, :version_number, :version
  end
end
