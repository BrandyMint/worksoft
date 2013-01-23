class DevelopersController < ApplicationController
  def index
    @developers = DeveloperProfile.order_by_activity
  end

  def show
    @developer = DeveloperProfile.find params[:id]
    @current_bundles = @developer.bundles.currents
  end
end
