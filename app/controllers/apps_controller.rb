# -*- coding: utf-8 -*-
class AppsController < ApplicationController
  def index
     @query = AppSearchQuery.new
     @bundles = active_bundles
  end

  def search
    @query = AppSearchQuery.new params[:app_search_query]

    if @query.valid?
      searcher = AppSearcher.new @query
      searcher.search params[:page]
      @bundles = searcher.filtered_bundles
    else
      @bundles = active_bundles
    end

    render :index
  end

  def show
    @app = App.find params[:id]
  end

  private

  def active_bundles
    # TODO Bundle.active
    App.ready.includes(:active_bundle).map {|a| a.active_bundle }
  end
end
