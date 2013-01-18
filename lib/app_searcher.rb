class AppSearcher
  attr_reader :q

  def initialize q
    @q = q
  end

  def search page, per_page = 20
    ransack_search page, per_page
  end

  private

  def ransack_search page, per_page
    App.search( q.ransack_query ).result
  end

  def sunspot_search page, per_page
    Sunspot.search(App) do
      fulltext q.name if q.name.present?
      with :kind_id, q.kind_id if q.kind_id.present?

      paginate :page => page, :per_page => per_page
    end.results
  end
end
