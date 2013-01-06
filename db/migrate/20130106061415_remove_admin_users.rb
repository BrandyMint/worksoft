class RemoveAdminUsers < ActiveRecord::Migration
  def change
    drop_table :admin_users, :force => true if ActiveRecord::Schema.tables.include? 'admin_users'

    User.destroy_all

    User.create :email => 'admin@example.com', :password => 'password'

    add_index :users, :email, :unique => true
  end
end
