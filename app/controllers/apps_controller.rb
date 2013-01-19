# -*- coding: utf-8 -*-
class AppsController < ApplicationController
  def index
     @query = AppSearchQuery.new
     @apps = App.ready
  end

  def search
    @query = AppSearchQuery.new params[:app_search_query]

    if @query.valid?
      searcher = AppSearcher.new @query
      @apps = searcher.search params[:page]
    else
      # flash[:alert] = 'Неверный поисковый запрос'
      @apps = App.ready
    end

    render :index
  end

  def show
    @app = App.find params[:id]
  end
end
