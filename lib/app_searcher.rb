class AppSearcher
  attr_reader :results
  
  def initialize q
    @q = q
    @results = nil
    @filter = BundleFilter.new q
  end

  def search page, per_page = 20
    @results = @filter.apply ransack_search( page, per_page )
  end

  private

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
