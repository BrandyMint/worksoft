class AppSearchQuery
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_reader :name, :kind_id, :kernel_version, :configuration_id

  def initialize params={}
    params = {} unless params.is_a? Hash
    @name = params['name']

    @kind_id = params['kind_id']
    @kind_id = @kind_id.present? ? @kind_id.to_i : nil
    @kind_id = nil if @kind_id == 0

    @configuration_id = params[:configuration_id]
    @configuration_id = @configuration_id.present? ? @configuration_id.to_i : nil
    @configuration_id = nil if @configuration_id == 0

    if params['kernel_version'].blank?
      @kernel_version = ''
    else
      @kernel_version = Version.new params[:kernel_version]
    end

  end

  def ransack_query
    h = {}
    h[:name_cont] = name if @name.present?
    h[:kind_id_eq] = kind_id if @kind_id.present?
    h[:configuration_id_eq] = configuration_id if @configuration_id.present?

    return h
  end

  def valid?
    name.present? || kind_id.present? || kernel_version.present? || configuration_id.present?
  end

  def persisted?
    false
  end
end
