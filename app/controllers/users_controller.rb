# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  before_filter :require_login, only: [:edit_profile, :profile, :resend_activation]

  def new
    @user ||= User.new
  end

  def create
    @user = User.new params[:user]
    if passwords_match_and_not_empty? && @user.save
      auto_login @user
      redirect_to root_url, :notice => t('notice.registration.success_registred')
    else
      flash.now[:error] = t("notice.registration.passwords_mystmatch_or_blank")
      render :new
    end
  end

  def activate
    if (@user = User.load_from_activation_token(params[:token]))
      @user.activate!
      auto_login @user
      redirect_to root_path, :notice => t('notice.email.confirmed')
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

  def profile
    @user = current_user
  end

  def edit_profile
    @user = current_user
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user]) 
      flash[:notice] = t('notice.profile_updated')
      redirect_to profile_path
    else
      render 'edit_profile'
    end  
  end

  def update_password
    @user = current_user

    if can_change_password?
      @user.change_password!(params[:user][:password])
      flash[:notice] = t('notice.password_changed')
      redirect_to profile_path
    else
      if User.authenticate(@user.email, params[:current_password])
        flash[:alert] = t('notice.passwords_mistmach')
      else
        flash[:alert] = t('notice.current_password_wrong')
      end
      render 'edit_profile'
    end
  end

private
  def can_change_password?
    passwords_match_and_not_empty? && current_user == User.authenticate(@user.email, params[:current_password])
  end

  def passwords_match_and_not_empty?
    !params[:user][:password].empty? && 
    params[:user][:password] == params[:user][:password_confirmation]
  end

end
