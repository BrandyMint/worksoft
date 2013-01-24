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
  def convert_and_filter_to_bundles apps
    apps.map do |app|
      bundles = app.bundles.active.ordered
      result_bundle = bundles.first
      if q.kernel_version.present?
        result_bundle = bundles.select { |b| b.kernel_version_matchers.match version }.first
      end
      result_bundle
    end.compact
  end

  def ransack_search page, per_page
    App.ready.search( q.ransack_query ).result
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
