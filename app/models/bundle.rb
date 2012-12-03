class Bundle < ActiveRecord::Base
  attr_protected :secret

  mount_uploader :source_file, FileUploader
  mount_uploader :bundle_file, FileUploader
  mount_uploader :icon, ImageUploader

  scope :ready, where(:state=>:ready)

  validates :name, :presence => true, :uniqueness => { :scope => :version }
  validates :version1c, :presence => true
  validates :versionconf, :presence => true
  validates :nameconf, :presence => true

  validates :version, :presence => true
  validates :source_file, :presence => true

  state_machine :state, :initial => :new do
    state :new
    state :updating
    state :ready
  end
end
