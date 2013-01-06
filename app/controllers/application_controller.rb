class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def authenticate!
    # before_filter :require_login
    require_login_from_http_basic
  end

  def realm_name_by_controller
    Settings.application.realm
  end
end
