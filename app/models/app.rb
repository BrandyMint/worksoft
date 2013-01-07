class App < ActiveRecord::Base
  attr_accessible :name, :icon, :desc

  has_many :bundles
  belongs_to :developer_profile, :counter_cache => true

  mount_uploader :icon, ImageUploader

  validates :name, :presence => true

  state_machine :state, :initial => :new do
    state :new
    state :updating
    state :ready
  end

  def to_s
    name
  end

  def next_version
    '0.1.0'
  end
end
