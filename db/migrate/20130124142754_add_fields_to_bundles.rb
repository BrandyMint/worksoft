class AddFieldsToBundles < ActiveRecord::Migration
  def up
    add_column :bundles, :name, :string
    add_column :bundles, :kind_id, :integer

    App.find_each do |app|
      app.bundles.update_all :name => app.name, :kind_id => app.kind_id
    end

    change_column :bundles, :name, :string, :null => false
    change_column :bundles, :kind_id, :integer, :null => false

    add_index :bundles, :name
    add_index :bundles, :kind_id
  end

  def down
    remove_column :bundles, :name
    remove_column :bundles, :kinde_id
  end
end
