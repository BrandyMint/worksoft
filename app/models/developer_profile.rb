class DeveloperProfile < ActiveRecord::Base
  attr_accessible :avatar, :name

  mount_uploader :avatar, ImageUploader

  has_one :user
  has_many :apps

  has_many :bundles, :through => :apps

  scope :order_by_activity, order(:apps_count)

  validates :name, :presence => true, :uniqueness => true

  def to_s
    name
  end
end
