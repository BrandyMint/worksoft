# encoding: utf-8
require 'acceptance/acceptance_helper'

feature 'Login', :js => true do
  before do
    @user = FactoryGirl.create(:user)
  end  
    
  scenario 'user should login' do
   capybara_sign_in_user @user
   page.body.should have_content I18n.t('notice.logged_in')
  end

  scenario 'user should fail login' do
   visit '/login'
   fill_in 'session_email', :with => 'lalala@spam.la'
   fill_in 'session_password', :with => '100500'
   find(".btn-primary").click
   page.body.should have_content I18n.t('notice.auth_failed')
  end

  scenario 'user should logout' do
    capybara_sign_in_user @user
    find('#logout').click
    page.body.should have_content I18n.t('notice.logged_out')
  end

  after do
    @user.destroy
  end
end
