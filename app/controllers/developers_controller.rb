class DevelopersController < ApplicationController
  def index
    @developers = DeveloperProfile.order_by_activity
  end

  def show
    @active_bundles = []
    @developer = DeveloperProfile.find params[:id]
    @developer.apps.each {|app| @active_bundles << app.active_bundle if app.active_bundle.present?}  
  end
end
