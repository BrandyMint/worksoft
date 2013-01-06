# -*- coding: utf-8 -*-
class Developer::ProfileController < ApplicationController
  skip_before_filter :require_developer, :only => [:create, :new]
  before_filter :require_login, :only => [:create, :new]
  before_filter :require_no_profile, :only => [:create, :new]
  
  def show
  end

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
  end

  def edit
  end

  private

  def require_no_profile
    if current_user.developer_profile.present?
      redirect_to developer_dashboard_url
    end
  end
end
