class RenameActiveBundleToCurrentBundle < ActiveRecord::Migration
  def change
    rename_column :apps, :active_bundle_id, :current_bundle_id
    App.all.each {|app| app.current_bundle.update_attribute :state, 'current' if app.current_bundle.present? }
  end
end
