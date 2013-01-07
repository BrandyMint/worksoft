class AddDescToApps < ActiveRecord::Migration
  def change
    add_column :apps, :desc, :text
    add_column :apps, :icon, :string
    remove_column :bundles, :icon
    rename_column :bundles, :desc, :changelog
  end
end
