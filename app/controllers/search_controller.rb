# -*- coding: utf-8 -*-
class SearchController < ApplicationController
  def new
    @search_query = BundleSearchQuery.new
  end

  def search_bundles
    @search_query = BundleSearchQuery.new params[:bundle_search_query]

    if @search_query.valid?
      searcher = BundleSearcher.new @search_query, params['page']
      @bundles = searcher.search
    else
      @bundles = Bundle.ready.page(params[:page]).per(20)
    end
  end
end
