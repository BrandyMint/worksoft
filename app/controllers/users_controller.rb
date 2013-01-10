# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  # before_filter :authenticate!

  def new
    @user ||= User.new
  end

  def create
    @user = User.new params[:user]
    if @user.save
      auto_login @user
      redirect_to root_url, :notice => t('notice.registred')
    else
      render :new
    end
  end
end
