class DevelopersController < ApplicationController
  def index
    @developers = DeveloperProfile.order_by_activity
  end

  def show
    @developer = DeveloperProfile.find params[:id]
    @current_bundles = @developer.ready.includes(:current_bundle).map &:current_bundle
  end
end
