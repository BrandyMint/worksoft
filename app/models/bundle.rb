# -*- coding: utf-8 -*-
require 'bundle_authorizer'

class Bundle < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'BundleAuthorizer'

  attr_accessible :source_file, :version, :app, :app_id, :changelog,
    :supported_kernel_versions, :supported_configurations_attributes,
    :source_file_cache

  mount_uploader :source_file, FileUploader
  mount_uploader :bundle_file, FileUploader

  # serialize :supported_kernel_versions, Hash

  scope :ready, where(:state=>:ready)
  scope :active, where('state != ?', :destroy)
  scope :destroyed, where(:state=>:destroy)
  scope :ordered, order(:version_number)
  scope :order_by_version, order(:version_number)
  scope :reverse_order_by_version, order("version_number DESC")

  belongs_to :app
  has_many :supported_configurations

  accepts_nested_attributes_for :supported_configurations, :allow_destroy => true
  
  validates :app, :presence => true
  validates :version_number, :presence => true, :uniqueness => { :scope => :app_id }
  validates :source_file, :presence => true, :app_kind_extension => true

  validates :supported_kernel_versions, :presence => true, :versions => true
  
  # composed_of :version, :allow_nil => true
  delegate :name, :desc, :kind_id, :icon, :to => :app

  state_machine :state, :initial => :new do
    state :new, :human_name => 'Новый'
    # state :updating
    state :ready, :human_name => 'Активен'
    state :destroy

    event :set_destroy do
      transition all => :destroy
    end

    event :publish do
      transition :new => :ready
    end

    event :restore do
      transition [:new, :destroy] => :ready
    end

    after_transition :ready => :destroy do |bundle|
      bundle.app.update_active_bundle
    end

    after_transition :new => :ready do |bundle, transition|
      bundle.app.activate_bundle bundle
    end
  end

  before_validation do
    self.supported_configurations ||= SupportedConfigurations.new
    self.uuid = UUID.new.generate
  end
  
  after_create :generate_bundle, :publish

  def generate_bundle
    BundlePacker.new(self).generate
  end

  def to_s
    "#{name} #{version}"
  end

  def kind
    'epf'
  end

  def ext
    File.extname source_file.file.file
  end

  def spec
    {
      :app => {
        :uuid => app.uuid,
        :name => app.name,
        :kind => app.kind
      },
      :bundle => {
        :uuid => uuid,
        :version => version
      },
      :compatibility => {
        :kernel_versions => kernel_versions,
        :configurations => configurations
      }
    }
  end

  def bundle_file_name
    uuid
  end

  def version
    Version.new version_number
  end

  def version= value
    value = Version.new value unless value.is_a? Version
    self.version_number = value.to_i
  end

  def destroy
    set_destroy
  end

  def kernel_version_matchers
    VersionMatchers.new supported_kernel_versions
  end

  private

  def kernel_versions
    []
  end

  def configurations
    []
  end
end
