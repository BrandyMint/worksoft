# -*- coding: utf-8 -*-
require 'app_bundle_defaults_extenstion'
class App < ActiveRecord::Base

  attr_accessible :name, :icon, :desc, :kind_id, :developer_profile_id


  belongs_to :developer_profile, :counter_cache => true
  belongs_to :active_bundle, :class_name => 'Bundle'
  belongs_to :kind
  has_many :bundles, :extend => AppBundleDefaultsExtension

  mount_uploader :icon, ImageUploader

  validates :name, :presence => true
  validates :kind, :presence => true

  scope :ready, where(:state=>:ready)

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

  delegate :version, :to => :active_bundle, :allow_nil => true

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

  def last_active_bundle
    bundles.ready.order_by_version.last
  end

  def update_active_bundle
    if last_active_bundle.present?
      activate_bundle last_active_bundle
    else
      update_attribute :active_bundle, nil
      idle
    end
  end

  def activate_bundle bundle
    update_attribute :active_bundle, bundle
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
end
