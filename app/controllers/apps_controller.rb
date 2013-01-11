class AppsController < ApplicationController
  def index
    @apps = App.ready
  end

  def show
    @app = App.find params[:id]
  end
end
