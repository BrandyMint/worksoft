# -*- coding: utf-8 -*-
class Developer::AppsController < Developer::BaseController

  before_filter :app, :only => [:edit, :show, :update]

  def new
    @app ||= App.new
  end

  def edit
  end

  def update
    if app.update_attributes params[:app]
      redirect_to new_developer_app_bundle_path(app), :notice => 'Приложение обновлено'
    else
      render :action => :edit
    end

  end

  def show
    @app = App.find params[:id]
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

  private
  def app
    @app = developer_profile.apps.find params[:id]
  end
end
