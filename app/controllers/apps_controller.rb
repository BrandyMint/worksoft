# -*- coding: utf-8 -*-
class AppsController < ApplicationController
  def index
     @query = AppSearchQuery.new
     @bundles = Bundle.currents
  end

  def search
    @query = AppSearchQuery.new params[:app_search_query]

    if @query.valid?
      searcher = AppSearcher.new @query
      searcher.search params[:page]
      @bundles = searcher.filtered_bundles
    else
      @bundles = Bundle.currents
    end

    render :index
  end

  def show
    @app = App.find params[:id]
  end

end
