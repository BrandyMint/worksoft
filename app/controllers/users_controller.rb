class UsersController < ApplicationController
  before_filter :authenticate!

  def profile
  end
end
