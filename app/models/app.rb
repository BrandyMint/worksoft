# -*- coding: utf-8 -*-
class App < ActiveRecord::Base
  attr_accessible :name, :icon, :desc

  belongs_to :developer_profile, :counter_cache => true
  has_many :bundles

  mount_uploader :icon, ImageUploader

  validates :name, :presence => true

  state_machine :state, :initial => :new do
    state :new, :human_name => 'В подготовке'
    #state :updating
    state :ready, :human_name => 'Обубликован'
  end

  def kind
    'epf'
  end

  def uuid
    id
  end

  def to_s
    name
  end

  def next_version
    '0.1.0'
  end
end
