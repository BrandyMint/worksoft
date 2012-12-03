class Bundle < ActiveRecord::Base
  attr_protected :secret

  mount_uploader :source_file, FileUploader
  mount_uploader :bundle_file, BundleUploader

  validates :name, :presence => true, :uniqueness => { :scope => :version }
  validates :version1c, :presence => true
  validates :versionconf, :presence => true
  validates :nameconf, :presence => true

  validates :version, :presence => true
  validates :file, :presence => true
end
