class AddUuidToBundles < ActiveRecord::Migration
  def change
    add_column :bundles, :uuid, :string, :null => false, :default => "7112ded0-1f9b-0130-60de-746d04736cf8"
    add_index :bundles, :uuid, :unique => true
  end
end
