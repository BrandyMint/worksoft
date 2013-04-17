class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :prepare_system

  helper_method :current_system

  def current_system
    self.current_system = param_system || session_system || UserSystem.new
  end

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

  def session_system
    if session[:system_id].blank?
      return nil
    else
      UserSystem.find_by_id session[:system_id]
    end
  end

  def current_system= value
    if value.blank?
      session[:system_id] = nil
    else
      session[:system_id] = value.id
    end
  end

  def param_system
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
