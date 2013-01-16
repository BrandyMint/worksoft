class BundleSearchQuery
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_reader :query, :kind_id, :kernel_version, :current_page

  def initialize params={}
    @query = params['query']
    @kind_id = params['kind_id']
    @kernel_version = params['kernel_version']
  end

  def valid?
    query.present? || kind_id.present? || kernel_version.present?
  end

  def persisted?
    false
  end
end
