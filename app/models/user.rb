# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  attr_accessor :password_confirmation
  rolify
  authenticates_with_sorcery!
  include Authority::UserAbilities

  belongs_to :developer_profile, :class_name => 'DeveloperProfile'
  validates :email, :presence => true, :uniqueness => true

  def to_s
    email
  end

  def activated?
    activation_state == 'active'
  end
end
