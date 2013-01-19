class AddIndexToConfigurations < ActiveRecord::Migration
  def change
    add_index :configurations, :name, :unique => true
  end
end
