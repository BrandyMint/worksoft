# -*- coding: utf-8 -*-
class Developer::ProfileController < Developer::BaseController
  skip_before_filter :require_developer, :only => [:create, :new]
  before_filter :require_login, :only => [:create, :new]
  before_filter :require_no_profile, :only => [:create, :new]

  def create
    if @profile = current_user.create_developer_profile( params[:developer_profile] )
      current_user.save!
      redirect_to developer_dashboard_path
    else
      render :action => :new
    end
  end

  def new
    @profile ||= DeveloperProfile.new
  end

  def update
    @profile = developer_profile

    if @profile.update_attributes params[:developer_profile]
      redirect_to developer_dashboard_path, :notice => 'Профиль обновлен!'
    else
      render :action => :edit
    end
  end

  def edit
    @profile ||= current_user.developer_profile
  end

  private

  def require_no_profile
    if developer_profile.present?
      redirect_to developer_dashboard_url
    end
  end
end
