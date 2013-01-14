# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  before_filter :require_login, :only => :resend_activation

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

  def activate
    if (@user = User.load_from_activation_token(params[:token]))
      @user.activate!
      redirect_to login_path, :notice => t('notice.email.confirmed')
    else
      render :file => "#{Rails.root}/public/404.html", layout: false
    end
  end

  def resend_activation
    unless current_user.activated?
      UserMailer.another_activation_email(current_user).deliver
      redirect_to :root, :notice => t('notice.email.confirmation_sent', email: current_user.email )
    else
      redirect_to :root, :notice => t('notice.email.already_confirmed', email: current_user.email )
    end
  end

end
