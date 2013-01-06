class RemoveAdminUsers < ActiveRecord::Migration
  def change
    drop_table :admin_users
    User.create :email => 'admin@example.com', :password => 'password'

    add_column :users, :name, :string

    add_index :users, :email, :unique => true
  end
end
