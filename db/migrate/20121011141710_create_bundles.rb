class CreateBundles < ActiveRecord::Migration
  def change
    create_table :bundles do |t|
      t.string :name, :null => false
      t.text :desc
      t.string :version1c, :null => false
      t.string :nameconf, :null => false
      t.string :versionconf, :null => false
      t.string :version, :null => false

      t.timestamps
    end

    add_index :bundles, :name, :unique => true
  end
end
