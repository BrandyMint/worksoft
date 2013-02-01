class UserSystem < ActiveRecord::Base
  attr_protected :secret

  belongs_to :user
  belongs_to :configuration

  validates :kernel_version_number, :presence => true
  validates :kernel_version, :versions => true

  validates :configuration_version_number, :presence => true
  validates :configuration_version, :versions => true

  def configuration_version
    Version.new configuration_version_number
  end

  def configuration_version= value
    value = Version.new value unless value.is_a? Version
    self.configuration_version_number = value.to_i
  end

  def kernel_version
    Version.new kernel_version_number
  end

  def kernel_version= value
    value = Version.new value unless value.is_a? Version
    self.kernel_version_number = value.to_i
  end

  def complete?
    kernel_version.present? && configuration.present? && configuration_version.present?
  end
end
