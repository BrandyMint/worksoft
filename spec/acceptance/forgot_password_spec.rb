# -*- coding: utf-8 -*-
require 'acceptance/acceptance_helper'

feature "Сброс пароля", %q{
  Пользователь заходит на страницу авторизации, кликает на ссылку *забыли пароль?* - переходит на страницу ввода email
  заполняет поле несуществующим email, получает ошибку
  заполняет поле правильным email, ему отправляется письмо с инструкциями по смене пароля
  
  пользователь кликает по ссылке в письме, попадает на страницу смены пароля
  вводит несовпадающие пароли - получает сообщение об ошибке
  вводит правельные пароли - получает сообщение об успешной смене пароля

  пользователь успешно авторизуется с новым паролем
}, :js => true do

  before do
    @user = FactoryGirl.create(:user)
    @user.activate!
  end

  scenario "Пользователь вспоминает пароль" do
    #Пользователь заходит на страницу авторизации, кликает на ссылку 'забыли пароль?' - переходит на страницу ввода email
    visit login_path
    find('.forgot_password').click
    page.body.should have_content 'Сброс пароля'

    #заполняет поле несуществующим email, получает ошибку
    fill_in 'email', :with => 'blablabla@blabla.bla'
    find('.btn-primary').click
    page.body.should have_content I18n.t("notice.reset_password.user_email_didnt_exist", email: "blablabla@blabla.bla")

    #заполняет поле правильным email, ему отправляется письмо с инструкциями по смене пароля
    fill_in 'email', :with => @user.email
    find('.btn-primary').click
    page.body.should have_content I18n.t("notice.reset_password.instructions_sent", email: @user.email)
  
    #пользователь кликает по ссылке в письме, попадает на страницу смены пароля
    @user.reload
    visit edit_password_reset_path(:id => @user.reset_password_token)
    page.body.should have_content 'Введите новый пароль'

    #вводит несовпадающие пароли - получает сообщение об ошибке
    fill_in 'user_password', :with => 'aaa'
    fill_in 'user_password_confirmation', :with => 'bbb'
    find('.btn-primary').click
    page.body.should have_content I18n.t("notice.reset_password.password_update_fail")

    #вводит правельные пароли - получает сообщение об успешной смене пароля
    fill_in 'user_password', :with => 'aaa'
    fill_in 'user_password_confirmation', :with => 'aaa'
    find('.btn-primary').click
    page.body.should have_content I18n.t("notice.reset_password.password_updated")

    #пользователь успешно авторизуется с новым паролем
    capybara_sign_in_user @user, 'aaa'
    page.body.should have_content I18n.t('notice.logged_in')
  end

  after do
    @user.destroy
  end

end
