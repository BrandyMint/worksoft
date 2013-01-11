# -*- coding: utf-8 -*-
require 'spec_helper'

describe UsersController do

  describe "POST 'create'" do
    it "рендерит шаблон :new" do
      post :create
      response.should render_template(:new)      
    end

    it "создает нового пользователя и отправляет письмо" do
      user = {email: "users@controller.com", password: '123456', password_confirmation:"123456"}  
      post :create, {user: user.to_hash }
      response.should redirect_to(root_url)
      confirmation_email = UserMailer.activation_needed_email User.last
      ActionMailer::Base.deliveries.last.should == confirmation_email
    end

  end

  describe "get 'resend_activation'" do
    before do
      @user = FactoryGirl.create(:user)
      login_user @user
    end
    
    it "отправляет пользователю повторное письмо-подтверждение" do
      confirmation_email = UserMailer.another_activation_email User.last
      get :resend_activation
      response.should redirect_to(root_url)
      flash[:notice].should == I18n.t('notice.email.confirmation_sent', email: @user.email )
      ActionMailer::Base.deliveries.last.should == confirmation_email
    end

    it "сообщает, что пользователь уже активирован" do
      @user.activate!
      get :resend_activation
      response.should redirect_to(root_url)
      flash[:notice].should == I18n.t('notice.email.already_confirmed', email: @user.email )
    end
  
    after do
      @user.destroy    
    end
  end

  describe "get 'activate'" do
    before do
      @user = FactoryGirl.create(:user)
    end
    
    it "активирует пользователя" do
      get :activate, token: @user.activation_token
      response.should redirect_to(login_path)
    end

    it "генерирует ошибку" do
      pending 'надо доработать'
      get :activate, token: 'blablabla'
      response.should raise_error(ActionController::RoutingError)
    end
  
    after do
      @user.destroy    
    end
  end


end 
