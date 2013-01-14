class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    respond_to do |format|
      if @user = login(params[:session][:email], params[:session][:password])
        format.html { redirect_back_or_to(:root, :notice => t('notice.logged_in')) }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { flash.now[:alert] = t('notice.auth_failed'); render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
    
  def destroy
    logout
    redirect_to(:root, :notice => t('notice.logged_out'))
  end
end
