class SupportedConfiguration < ActiveRecord::Base
  attr_accessible :configuration_id, :bundle_id, :version

  belongs_to :configuration
  belongs_to :bundle

  #validates :configuration_id, :presence => true, :uniqueness => { :scoe => :bundle_id }
  #validates :bundle_id, :presence => true

  def version
    Version.new version_number || '0.1'
  end

  def version= value
    self.version_number = Version.new(value).to_i
  end
end
