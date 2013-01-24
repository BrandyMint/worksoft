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

  scope :currents, where(:state=>:current)
  scope :ready, where(:state=>:ready)
  scope :active, where(:state => [:ready, :current])
  scope :live, where('state != ?', :destroy)
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
  delegate :name, :desc, :kind_id, :kind, :icon, :to => :app

  state_machine :state, :initial => :new do
    state :new
    # state :updating
    state :ready
    state :current
    state :destroy

    event :publish do
      transition :new => :current
    end

    event :set_ready do
      transition :current => :ready    
    end

    event :restore do
      transition [:new, :destroy] => :ready
    end

    after_transition any => :destroy do |bundle|
      bundle.app.update_current_bundle
    end

    after_transition :new => :current do |bundle, transition|
      bundle.app.set_current_bundle bundle
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

  def update_bundle
    FileUtils.rm bundle_file.file.file if bundle_file.file.present?
    generate_bundle
  end

  def to_s
    "#{name} #{version}"
  end

  def ext
    File.extname source_file.file.file
  end

  def spec
    {
      'app' => {
        'uuid' => app.uuid,
        'name' => app.name,
        'kind' => ext
      },
      'bundle' => {
        'uuid' => uuid,
        'version' => version.to_s
      },
      'compatibility' => {
        'kernel_versions' => kernel_versions,
        'configurations' => configurations
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

  def kernel_version_matchers
    VersionMatchers.new supported_kernel_versions
  end

  def set_destroy
    update_column :state, 'destroy'
  end

  private

  def kernel_versions
    supported_kernel_versions
  end

  def configurations
    confs = []
    supported_configurations.each{|sc| confs << sc.configuration.name}
    confs.join(", ")
  end
end
