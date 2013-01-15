class CreateKind < ActiveRecord::Migration
  def change
    create_table :kinds do |t|
      t.string :title, :null => false
      t.string :ext, :null => false, :length => 3
      
      t.timestamps
    end

    add_column :apps, :kind_id, :integer
    add_index :apps, :kind_id
  end
end
