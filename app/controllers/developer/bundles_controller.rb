# -*- coding: utf-8 -*-
class Developer::BundlesController < Developer::BaseController
  before_filter :app

  def index
    redirect_to developer_app_path(@app)
  end

  def new
    @bundle ||= app.bundles.build
  end

  def create
    debugger
    @bundle = app.bundles.build( params[:bundle] )
    if @bundle.save
      redirect_to developer_app_path(@app), :notice => "Загружена новая версия #{@bundle.version} приложения #{app}"
    else
      render :new
    end
  end

  def destroy
    bundle.set_destroy
    redirect_to developer_app_path(bundle.app), :notice => "Версия #{bundle} дезактивирована"
  end

  def restore
    if bundle.restore
      redirect_to developer_app_path(bundle.app), :notice => "Версия #{bundle} активирована"
    else
      redirect_to developer_app_path(bundle.app), :alert => "Ошибка восстановления #{bundle}!"
    end
  end

  private

  def bundle
    app.bundles.find params[:id]
  end

  def app
    @app ||= developer_profile.apps.find params[:app_id]
  end
end
