class ApplicationController < ActionController::Base
  protect_from_forgery

  private

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
