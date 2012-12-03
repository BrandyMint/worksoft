class AddStateToBundles < ActiveRecord::Migration
  def change
    add_column :bundles, :state, :string

    add_index :bundles, :state
  end
end
