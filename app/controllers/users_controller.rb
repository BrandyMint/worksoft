class UsersController < ApplicationController
  before_filter :require_login_from_http_basic
  # before_filter :require_login

  def profile
  end
end
