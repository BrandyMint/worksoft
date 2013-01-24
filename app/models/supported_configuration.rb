class SupportedConfiguration < ActiveRecord::Base
  attr_accessible :configuration_id, :bundle_id, :version

  belongs_to :configuration
  belongs_to :bundle

  validates :versions, :versions => true

  def to_s
    if versions.to_s.present?
      configuration.to_s + " (#{versions})"
    else
      configuration.to_s
    end
  end

  def version_matchers
    VersionMatchers.new versions
  end

end
