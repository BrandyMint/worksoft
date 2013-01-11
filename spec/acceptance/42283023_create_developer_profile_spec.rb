# encoding: utf-8

require 'acceptance/acceptance_helper'
feature 'Регистрация разработчика (создание профиля)', %q{
  На гланвную страницу заходит пользователь, не имеющий профиля разработчика.
  Идет на страницу /developer/ 
  Так как он не имеет профиля, его кидает на страницу регистрации разработчика.
  Он регистрируется (устанавливает имя и загружает лого).
  После чего попадает на страницу /developer/apps.
  
  https://www.pivotaltracker.com/story/show/42283023

}, :js => true do

  before do
    @user = FactoryGirl.create(:user)
  end

  scenario 'unsigned user pass to registration when trying to access developer page' do
    capybara_sign_in_user @user
    
    find('#dashboard').click
    page.body.should have_content I18n.t('notice.you_need_to_be_developer')
    
    fill_in 'developer_profile_name', :with => 'developer_username'
    #TODO разобраться с загрузкой изображения https://github.com/jonleighton/poltergeist/issues/115
    debugger
    #attach_file('developer_profile_avatar', Rails.root + 'spec/fixtures/upic.gif')
    find('.btn-primary').click
    page.body.should have_content "developer_username"
    #page.should have_xpath("//img[@alt='Thumb_48_picture--240']")
  end

  after do
    @user.destroy
  end

  
end
