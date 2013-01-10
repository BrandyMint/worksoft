class Bundle < ActiveRecord::Base
  attr_accessible :source_file, :version, :app, :app_id, :changelog, :version_str, :supported_kernel_versions

  mount_uploader :source_file, FileUploader
  mount_uploader :bundle_file, FileUploader

  # serialize :supported_kernel_versions, Hash

  scope :ready, where(:state=>:ready)
  scope :active, where('state != ?', :destroy)
  scope :destroyed, where(:state=>:destroy)
  scope :order_by_version, order(:version)
  scope :reverse_order_by_version, order("version DESC")

  belongs_to :app

  validates :app, :presence => true
  validates :version, :presence => true
  validates :source_file, :presence => true

  validates :supported_kernel_versions, :presence => true, :versions => true

  composed_of :version, :allow_nil => true
  delegate :name, :desc, :to => :app

  state_machine :state, :initial => :new do
    state :new
    state :updating
    state :ready
    state :destroy

    event :set_destroy do
      transition all => :destroy    
    end

    event :publish do
      transition :new => :ready
    end

    after_transition :new => :ready, :do => :set_app_bundle
  end

  

  before_validation do
    self.supported_configurations ||= SupportedConfigurations.new
    self.uuid = UUID.new.generate
  end

  after_create :generate_bundle, :set_app_bundle
  after_destroy :set_app_bundle

  def generate_bundle
    BundlePacker.new(self).generate
  end

  def set_app_bundle
    self.app.set_last_bundle
  end

  def to_s
    name
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

  def version_str
    #@version_str ||= version.to_s
    version.to_s
  end

  def version_str= value
    #@version_str = value
    self.version = Version.new value
  rescue
    self.version = nil
  end
    
  private

  def set_version
    return unless @version_str.present?

    self.version = Version.new @version_str
  rescue
    errors.add(:version, :broken)
  end

  def kernel_versions
    []
  end

  def configurations
    []
  end
end
