class ApplicationController < ActionController::Base
  include Devise::Controllers::Helpers
  protect_from_forgery
  # before_filter :authenticate_user!
end
