class AppsController < ApplicationController
  def index
     @search_query = BundleSearchQuery.new
     @apps = App.ready
  end

  def show
    @app = App.find params[:id]
  end
end
