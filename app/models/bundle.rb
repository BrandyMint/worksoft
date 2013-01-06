class Bundle < ActiveRecord::Base
  attr_protected :secret

  mount_uploader :source_file, FileUploader
  mount_uploader :bundle_file, FileUploader
  mount_uploader :icon, ImageUploader

  scope :ready, where(:state=>:ready)

  validates :name, :presence => true, :uniqueness => { :scope => :version }

  validates :version1c, :presence => true
  validates :versionconf, :presence => true
  validates :nameconf, :presence => true

  validates :version, :presence => true
  validates :source_file, :presence => true

  state_machine :state, :initial => :new do
    state :new
    state :updating
    state :ready
  end

  before_validation do
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
        :uuid => uuid,
        :name => name,
        :kind => kind
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
