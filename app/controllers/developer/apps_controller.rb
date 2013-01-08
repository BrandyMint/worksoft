# -*- coding: utf-8 -*-
class Developer::AppsController < Developer::BaseController
  def new
    @app ||= App.new
  end

  def show
    @app = App.find params[:id]
    redirect_to developer_apps_path
  end

  def index
    @apps = developer_profile.apps
  end

  def create
    @app = developer_profile.apps.build params[:app]

    if @app.save
      redirect_to new_developer_app_bundle_path(@app), :notice => 'Приложение добавлено'
    else
      render :action => :new
    end
  end
end
