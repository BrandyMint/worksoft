# -*- coding: utf-8 -*-
require 'app_bundle_defaults_extenstion'
class App < ActiveRecord::Base

  attr_accessible :name, :icon, :desc, :kind_id, :developer_profile_id

  belongs_to :developer_profile, :counter_cache => true
  belongs_to :current_bundle, :class_name => 'Bundle'
  belongs_to :kind
  has_many :bundles, :extend => AppBundleDefaultsExtension

  mount_uploader :icon, ImageUploader

  validates :name, :presence => true
  validates :kind, :presence => true

  scope :ready, where(:state=>:ready)

  after_save :recreate_bundles_files

  state_machine :state, :initial => :new do
    state :new, :human_name => 'Готовится'
    #state :updating
    state :ready, :human_name => 'Опубликовано'

    event :publish do
      transition :new => :ready
    end

    event :idle do
      transition all => :new
    end
  end

  delegate :version, :to => :current_bundle, :allow_nil => true

  if defined? Sunspot
    searchable do
      text :name
      integer :kind_id
    end
  end

  def last_bundle
    bundles.order_by_version.last
  end

  def uuid
    id
  end

  def to_s
    name
  end

  def last_current_bundle
    bundles.ready.order_by_version.last
  end

  def update_current_bundle
    if last_current_bundle.present?
      set_current_bundle last_current_bundle  ## Set current bundle
    else
      update_attribute :current_bundle, nil
      idle
    end
  end

  def set_current_bundle bundle
    current_bundle.set_ready if current_bundle.present?
    update_attribute :current_bundle, bundle
    publish
  end

  # TODO Вынести в presenter
  def matched_bundles version
    matched = bundles.ready.ordered

    if version.present?
      matched.select { |b| b.kernel_version_matchers.match version }
    else
      matched
    end

  end

  def matched_configuration conf_id
    matched = bundles.ready.ordered

    if conf_id.present?
      matched.select { |b| b.supported_configurations.map(&:configuration_id).include? conf_id }
    else
      matched
    end

  end


private
  def recreate_bundles_files
    bundles.each {|bundle| bundle.update_bundle}  
  end
end
