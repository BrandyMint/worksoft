class Bundle < ActiveRecord::Base
  attr_protected :secret

  mount_uploader :file, FileUploader

  validates :name, :presence => true, :uniqueness => { :scope => :version }
  validates :version1c, :presence => true
  validates :versionconf, :presence => true
  validates :nameconf, :presence => true

  validates :version, :presence => true
  validates :file, :presence => true
end
