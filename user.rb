# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me

  has_many :authentications, :dependent => :destroy

  devise :database_authenticatable, :registerable, :confirmable, 
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable,
         :omniauthable


  class << self
    def find_or_create_from_auth_hash access_token
      auth = Authentication.where(:uid=> access_token['uid'], :provider => access_token['provider']).first

      return auth.user if auth.present?

      User.register_user_and_auth access_token
    end

    def register_user_and_auth access_token
      user = User.create!(
        :email        => access_token['info']['email'],
        :username     => access_token['info']['name']  || access_token['info']['nickname'] ,
        :password     => Devise.friendly_token[0,20]
      )
      user.confirm!

      Authentication.create_from_token access_token, user

      user
    end
  end

  def to_s
    username || email
  end
end
