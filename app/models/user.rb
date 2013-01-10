# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  attr_accessor :password_confirmation
  rolify
  authenticates_with_sorcery!
  include Authority::UserAbilities

  belongs_to :developer_profile, :class_name => 'DeveloperProfile'

  def to_s
    email
  end
end