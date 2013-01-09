class Bundle < ActiveRecord::Base
  attr_accessible :source_file, :version, :app, :app_id, :changelog

  mount_uploader :source_file, FileUploader
  mount_uploader :bundle_file, FileUploader

  scope :ready, where(:state=>:ready)

  belongs_to :app

  validates :app, :presence => true
  validates :version, :presence => true
  validates :source_file, :presence => true

  #validates :version1c, :presence => true
  #validates :versionconf, :presence => true
  #validates :nameconf, :presence => true

  composed_of :version
  composed_of :supported_configurations
  delegate :name, :desc, :to => :app

  state_machine :state, :initial => :new do
    state :new
    state :updating
    state :ready
  end

  before_validation do
    self.supported_configurations ||= SupportedConfigurations.new
    self.uuid = UUID.new.generate
  end

  after_create :generate_bundle

  def generate_bundle
    BundlePacker.new(self).generate
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

  private

  def kernel_versions
    []
  end

  def configurations
    []
  end
end
