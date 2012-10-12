# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me

  has_many :authentications, :dependent => :destroy

  devise :database_authenticatable, :registerable, :confirmable, 
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  def to_s
    username || email
  end
end
