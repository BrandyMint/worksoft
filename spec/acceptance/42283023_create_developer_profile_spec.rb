# encoding: utf-8
require 'acceptance/acceptance_helper'

# https://www.pivotaltracker.com/story/show/42283023

feature 'Регистрация разработчика (создание профиля)', %q{
  На гланвную страницу заходит пользователь, не имеющий профиля разработчика.
  Идет на страницу /developer/ 
  Так как он не имеет профиля, его кидает на страницу регистрации разработчика.
  Он регистрируется (устанавливает имя и загружает лого).
  После чего попадает на страницу /developer/apps.

}, :js => true do

  before do
    @user = FactoryGirl.create(:user)
  end

  scenario 'Будущий разработчик создает свой профиль' do
    capybara_sign_in_user @user

    find('#dashboard').click
    page.body.should have_content I18n.t('notice.you_need_to_be_developer')

    fill_in 'developer_profile_name', :with => 'developer_username'
    attach_file 'developer_profile[avatar]', Rails.root + 'spec/fixtures/upic.gif'
    find('.btn-primary').click

    page.body.should have_content "developer_username"
    page.should have_xpath("//img[@src='/uploads/developer_profile/avatar/1/thumb_48_upic.gif']")
  end

  after do
    @user.destroy
  end

end
