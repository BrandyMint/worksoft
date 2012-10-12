class AddFileToBundles < ActiveRecord::Migration
  def change
    add_column :bundles, :file, :string
  end
end
