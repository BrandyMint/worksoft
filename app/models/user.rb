# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  include Authority::UserAbilities

  attr_accessor :password_confirmation
  rolify
  authenticates_with_sorcery!

  belongs_to :developer_profile, :class_name => 'DeveloperProfile'
  #TODO валидатор адреса электронной почты
  validates :email, :presence => true, :uniqueness => true

  def to_s
    email
  end

  def activated?
    activation_state == 'active'
  end
end
