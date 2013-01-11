# -*- coding: utf-8 -*-
class Developer::BundlesController < Developer::BaseController
  before_filter :app

  def index
    redirect_to developer_app_path(@app)
  end

  def new
    @bundle ||= Bundle.new :version => app.next_version
  end

  def create
    @bundle = app.bundles.build( params[:bundle] )
    if @bundle.save
      redirect_to developer_app_path(@app), :notice => "Загружена новая версия #{@bundle.version} приложения #{app}"
    else
      render :new
    end
  end

  def destroy
    bundle = Bundle.find params[:id]
    bundle.destroy
    redirect_to developer_app_path(bundle.app)    
  end

  private

  def app
    @app ||= developer_profile.apps.find params[:app_id]
  end
end
