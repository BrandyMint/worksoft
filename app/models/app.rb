# -*- coding: utf-8 -*-
class App < ActiveRecord::Base
  attr_accessible :name, :icon, :desc

  belongs_to :developer_profile, :counter_cache => true
  belongs_to :active_bundle, :class_name => 'Bundle'
  has_many :bundles

  mount_uploader :icon, ImageUploader

  validates :name, :presence => true

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

  def last_bundle
    bundles.order_by_version.last
  end

  def kind
    # epr
    'epf'
  end

  def uuid
    id
  end

  def to_s
    name
  end

  def next_version
    if last_bundle.present?
      last_bundle.version.next
    else
      Version.new '0.1'
    end
  end

  def last_active_bundle
    bundles.ready.order_by_version.last
  end

  def set_last_bundle
    if last_active_bundle
      update_attribute :active_bundle, last_active_bundle
      publish
    else
      update_attribute :active_bundle, nil
      idle
    end
  end
end
