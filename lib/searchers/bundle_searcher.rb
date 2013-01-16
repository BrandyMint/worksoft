class BundleSearcher
  attr_reader :q, :page

  def initialize q, current_page
    @q = q
    @page = current_page
  end

  def search
    search = Sunspot.search(Bundle) do
      fulltext q.query if q.query.present?

      with :kind_id, q.kind_id if q.kind_id.present?
      with :supported_kernel_versions, q.kernel_version if q.kernel_version.present?
      paginate :page => page, :per_page => 20
    end

    search.results
  end
end
