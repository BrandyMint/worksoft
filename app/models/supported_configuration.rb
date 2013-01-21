class SupportedConfiguration < ActiveRecord::Base
  attr_accessible :configuration_id, :bundle_id

  belongs_to :configuration
  belongs_to :bundle

  #validates :configuration_id, :presence => true, :uniqueness => { :scoe => :bundle_id }
  #validates :bundle_id, :presence => true

end
