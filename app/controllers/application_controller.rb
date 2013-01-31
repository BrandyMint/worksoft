class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user_system

  def current_user_system
    session[:user_system] ||= UserSystem.new :kernel_version => '8.1.34', :configuration => ::Configuration.first, :configuration_version => '1.2.3.4'
  end

  def current_user_system= value
    session[:user_system] = value
  end

  def authenticate_admin_user!
    if logged_in? && current_user.has_role?( :admin )
      return true
    else
      authenticate!
    end
  end

  def authenticate!
    require_login
    # require_login_from_http_basic unless logged_in?
  end

  def realm_name_by_controller
    Settings.application.realm
  end

  def not_authenticated
    # TODO 403?
    redirect_to login_path
  end
end
