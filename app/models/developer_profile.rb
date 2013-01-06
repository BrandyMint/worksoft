class DeveloperProfile < ActiveRecord::Base
  attr_accessible :avatar, :name

  mount_uploader :avatar, ImageUploader

  has_one :user
  has_many :apps

  scope :order_by_activity, order(:apps_count)

  validates :name, :presence => true, :uniqueness => true
end
