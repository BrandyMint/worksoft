class App < ActiveRecord::Base
  has_many :bundles
  belongs_to :developer_profile, :counter_cache => true

  mount_uploader :icon, ImageUploader

  validates :name, :presence => true, :uniqueness => { :scope => :version }
end
