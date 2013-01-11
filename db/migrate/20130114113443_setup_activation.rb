class SetupActivation < ActiveRecord::Migration
  def up
    User.find_each do |u|
      u.send :setup_activation
      u.save!
    end
  end

  def down
  end
end
