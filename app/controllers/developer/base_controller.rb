# -*- coding: utf-8 -*-
class Developer::BaseController < ApplicationController
  before_filter :require_developer
  layout 'developer'

  private

  def developer_profile
    current_user.developer_profile
  end

  def require_developer
    require_login

    if logged_in?
      if !current_user.activated?
        redirect_to :root, :notice => t('notice.email.need_confirm', link: resend_activation_path).html_safe
      elsif !current_user.developer_profile.present?
        redirect_to new_developer_profile_path, :notice => t('notice.you_need_to_be_developer')
      end
    end
  end
end
