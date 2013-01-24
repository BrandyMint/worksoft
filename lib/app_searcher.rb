class AppSearcher
  attr_reader :q, :results, :kernel_version
  
  def initialize q
    @q = q
    @results = nil
  end

  def search page, per_page = 20
    @results = convert_and_filter_to_bundles ransack_search( page, per_page )
  end

  private

  # Конвертирует app в bundle и фильтрует по запросу
  def convert_and_filter_to_bundles bundles
    bundles.map do |app|
      if q.kernel_version.present?
        bundles.select! { |b| b.kernel_version_matchers.match version }
      end

      if q.configuration_id.present? && q.configuration_version.present?
        sc = bundles.supported_configurations.where(:configuration_id => q.configuration_id).first
        bundles.select! { |b| b.sc.match q.configuration_version }
      end

      bundles.first
    end.compact
  end

  def ransack_search page, per_page
    scope = Bundle.active.ordered

    if q.configuration_id.present?
      scope = scope.joins(:supported_configurations).
        where( :supported_configurations => { :configuration_id => q.configuration_id } )
    end

    scope = scope.search( q.ransack_query ).result
  end

  # broken
  #def sunspot_search page, per_page
    #Sunspot.search(App) do
      #fulltext q.name if q.name.present?
      #with :kind_id, q.kind_id if q.kind_id.present?

      #paginate :page => page, :per_page => per_page
    #end.results
  #end
end
