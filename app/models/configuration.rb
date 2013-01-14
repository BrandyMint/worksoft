class Configuration < ActiveRecord::Base
  attr_accessible :name

  has_many :supported_configurations

  def to_s
    name
  end
end
