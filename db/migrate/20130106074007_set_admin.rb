class SetAdmin < ActiveRecord::Migration
  def up
    User.find_each do |u|
      u.add_role :admin
      u.save!
    end
  end
end
