class UserSystem < ActiveRecord::Base
  attr_protected :secret

  #belongs_to :user
  belongs_to :configuration

  validates :kernel_version_number, :presence => true
  validates :kernel_version, :versions => true

  validates :configuration_version_number, :presence => true
  validates :configuration_version, :versions => true

  def self.find_or_create_by_system system
    where(:configuration_id => system[:configuration].id,
          :kernel_version_number => system[:kernel_version].to_i,
          :configuration_version_number => system[:configuration_version].to_i).first ||
    create!(system)
  end

  def configuration= value
    if value.is_a? String
      super Configuration.find_or_create_by_name(value)
    else
      super value
    end
  end

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
