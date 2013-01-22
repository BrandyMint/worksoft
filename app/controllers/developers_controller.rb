class DevelopersController < ApplicationController
  def index
    @developers = DeveloperProfile.order_by_activity
  end

  def show
    @developer = DeveloperProfile.find params[:id]
    @active_bundles = @developer.ready.includes(:active_bundle).map( &:active_bundle )
  end
end
