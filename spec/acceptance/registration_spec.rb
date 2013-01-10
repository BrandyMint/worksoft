# encoding: utf-8
require 'acceptance/acceptance_helper'
feature 'Registration', :js => true do
  scenario "user should register" do
    visit '/users/new'
    fill_in 'user_email', :with => 'user@worksoft.ru'
    fill_in 'user_password', :with => 'ololoshkanavsegda'
    fill_in 'user_password_confirmation', :with => 'ololoshkanavsegda'
    find(".btn-primary").click
    page.status_code.should eq(200)
    page.body.should have_content I18n.t('notice.registred')
  end
end
