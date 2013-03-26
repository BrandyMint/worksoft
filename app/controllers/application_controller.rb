class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :prepare_system

  helper_method :current_system

  private

  def prepare_system
    if params[:system]
      params[:system] = {
        :configuration  => ::Configuration.find_or_create_by_name( params[:system][:configuration] ),
        :kernel_version => Version.new( params[:system][:kernel_version] ),
        :configuration_version => Version.new( params[:system][:configuration_version] )
      }
    end
  end

  def current_system
    system || session[:system] || UserSystem.new
  end

  def current_system= value
    session[:system] = value
  end

  def system
    if params[:system]
      UserSystem.find_or_create_by_system params[:system]
    else
      return nil
    end
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
