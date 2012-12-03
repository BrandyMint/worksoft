class RenameFileToBundleFile < ActiveRecord::Migration
  def up
    rename_column :bundles, :file, :source_file

    add_column :bundles, :bundle_file, :string
    add_column :bundles, :icon, :string
  end

  def down
  end
end
