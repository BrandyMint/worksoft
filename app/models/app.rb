# -*- coding: utf-8 -*-
require 'app_bundle_defaults_extenstion'
class App < ActiveRecord::Base
  attr_accessible :name, :icon, :desc, :kind_id, :kind

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

  def activate_bundle bundle
    if bundle
      update_attribute :active_bundle, bundle
      publish
    else
      update_attribute :active_bundle, nil
      idle
    end
  end
end
