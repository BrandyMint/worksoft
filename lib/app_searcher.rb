class AppSearcher
  attr_reader :results, :q, :kind, :user_system
  
  def initialize q, user_system, kind
    @q = q
    @kind = kind
    @user_system = user_system

    @results = nil
    @filter = BundleFilter.new user_system
  end

  def search page, per_page = 20
    @results = @filter.apply ransack_search( page, per_page )
  end

  private

  def ransack_search page, per_page
    scope = Bundle.active.ordered

    if user_system.configuration_id.present?
      scope = scope.joins(:supported_configurations).
        where( :supported_configurations => { :configuration_id => user_system.configuration_id } )
    end

    scope = scope.search( ransack_query ).result
  end

  def ransack_query
    h = {}
    h[:name_cont] = q.name if q.name.present?
    h[:kind_id_eq] = kind.id if kind.present?

    return h
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
