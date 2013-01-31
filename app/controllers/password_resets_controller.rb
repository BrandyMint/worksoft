# -*- coding: utf-8 -*-
class PasswordResetsController < ApplicationController
  skip_before_filter :require_login

  def create 
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_reset_password_instructions!
      redirect_to(root_path, :notice => t("notice.reset_password.instructions_sent", email: @user.email))
    else
      flash[:error] = t("notice.reset_password.user_email_didnt_exist", email: params[:email])
      render :action => "new"
    end
  end
    
  def edit
    @user = User.load_from_reset_password_token(params[:id])
    @token = params[:id]
    unless @user
      flash[:error] = t("notice.reset_password.reset_link_fail")
      not_authenticated 
    end
  end
      
  def update
    @user = User.load_from_reset_password_token(params[:user][:reset_password_token])

    not_authenticated unless @user
    @user.password_confirmation = params[:user][:password_confirmation]

    if can_change_password? && @user.change_password!(params[:user][:password])
      redirect_to(login_path, :notice => t("notice.reset_password.password_updated"))
    else
      flash[:error] = t("notice.reset_password.password_update_fail")
      render :action => "edit"
    end
  end

private
  def can_change_password?
    !params[:user][:password].empty? && params[:user][:password] == params[:user][:password_confirmation] && @user.present?
  end

end
