class AppSearchQuery
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_reader :name, :kind_id, :kernel_version

  def initialize params={}
    @name = params['name']
    @kind_id = params['kind_id']
    @kind_id = @king_id.to_i if @kind_id.present?
    @kernel_version = params['kernel_version']
  end

  def ransack_query
    {:name_containts => name, :kind_id_eq => kind_id}
  end

  def valid?
    name.present? || kind_id.present? || kernel_version.present?
  end

  def persisted?
    false
  end
end
