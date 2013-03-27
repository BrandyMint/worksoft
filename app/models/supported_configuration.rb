# -*- coding: utf-8 -*-
class SupportedConfiguration < ActiveRecord::Base
  attr_accessible :configuration_id, :bundle_id, :versions

  belongs_to :configuration
  belongs_to :bundle

  validates :versions, :versions => true

  delegate :match, :to => :version_matchers

  before_validation do
    self.versions='' unless configuration.present?
  end

  def to_s
    if configuration.present?
      if versions.to_s.present?
        configuration.to_s + " (#{versions})"
      else
        configuration.to_s
      end
    else
      'любая конфигурация'
    end
  end

  def version_matchers
    VersionMatchers.new versions
  end

end
