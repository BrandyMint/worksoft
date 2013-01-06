class User < ActiveRecord::Base
  rolify
  authenticates_with_sorcery!

  def to_s
    name || "User##{id.to_s}"
  end
end
