class UserSystemsController < ApplicationController
  def new
    @user_system = self.current_system
  end

  def create
    self.current_system = UserSystem.new params[:user_system]

    redirect_to root_url
  end

  def edit
    @user_system = self.current_system
  end

  def update
    self.current_system = UserSystem.new params[:user_system]

    redirect_to root_url
  end
end
