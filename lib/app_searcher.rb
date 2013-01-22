class AppSearcher
  attr_reader :q, :results, :kernel_version
  
  def initialize q
    @q = q
    @results = nil
  end

  def search page, per_page = 20
    @results = ransack_search page, per_page
    @results = filter_by_kenerl_versions @results
  end

  def filtered_bundles
    if @results.present?
      @results.map { |app| app.matched_bundles( q.kernel_version ).first }.compact
    else
      []
    end
  end

  private

  # Оставляем только те app, у которых есть bundles удовлетворяющие kernel_version.
  def filter_by_kenerl_versions list
    return list unless q.kernel_version.present?

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
