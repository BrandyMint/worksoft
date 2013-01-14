class CreateSupportedConfigurations < ActiveRecord::Migration
  def up
    create_table :supported_configurations do |t|
      t.integer :bundle_id, :null => false
      t.integer :configuration_id, :null => false

      t.timestamps
    end

    add_index :supported_configurations, [:configuration_id, :bundle_id], :name => :sc_idx  #, :unique => true
    add_index :supported_configurations, :bundle_id, :name => :sc_idx2

    remove_column :bundles, :supported_configurations
  end

  def down
    drop_table :supported_configurations
    add_column :bundles, :supported_configurations, :string
  end
end
