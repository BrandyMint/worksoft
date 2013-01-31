# encoding: utf-8
require 'acceptance/acceptance_helper'
feature 'Регистрация пользователя', %q{
  Пользователь заходит на страницу регистрации
  вводит email и не вводит пароли - получает ошибку
  вводит email и вводит не совпадающие пароли - получает ошибку
  вводит неправильный email и совпадающие пароли - получает ошибку
  вводит правильный email и совпадающие пароли - успешно регистрируется
}, :js => true do
  before(:each) do
    visit '/'
    find('li#signup a').click
  end

  scenario "вводит email и не вводит пароли - получает ошибку" do
    fill_in 'user_email', :with => 'user@worksoft.ru'
    find(".btn-primary").click

    page.body.should have_content I18n.t("notice.registration.passwords_mystmatch_or_blank")
  end

  scenario "вводит email и вводит не совпадающие пароли - получает ошибку" do
    fill_in 'user_email', :with => 'user@worksoft.ru'
    fill_in 'user_password', :with => 'abc'
    fill_in 'user_password_confirmation', :with => 'ololoshkanavsegda'
    find(".btn-primary").click

    page.body.should have_content I18n.t("notice.registration.passwords_mystmatch_or_blank")
  end

  scenario "вводит неправильный email и совпадающие пароли - получает ошибку" do
    fill_in 'user_email', :with => 'useremail.ru'
    fill_in 'user_password', :with => 'ololoshkanavsegda'
    fill_in 'user_password_confirmation', :with => 'ololoshkanavsegda'
    find(".btn-primary").click

    page.body.should have_content I18n.t('activerecord.errors.models.user.attributes.email.email')
  end


  scenario "вводит правильный email и совпадающие пароли - успешно регистрируется" do
    fill_in 'user_email', :with => 'user@worksoft.ru'
    fill_in 'user_password', :with => 'ololoshkanavsegda'
    fill_in 'user_password_confirmation', :with => 'ololoshkanavsegda'
    find(".btn-primary").click

    page.body.should have_content I18n.t('notice.registration.success_registred')
  end


end
