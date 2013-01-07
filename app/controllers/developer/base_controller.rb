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

    if logged_in? && ! current_user.developer_profile.present?
      redirect_to new_developer_profile_path, :notice => 'Для управления профилем разработчика его необходимо сначала создать.'
    end
  end
end
