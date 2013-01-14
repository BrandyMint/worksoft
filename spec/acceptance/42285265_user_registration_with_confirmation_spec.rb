# encoding: utf-8
require 'acceptance/acceptance_helper'

# https://www.pivotaltracker.com/story/show/42283023

feature 'Регистрация разработчика (создание профиля)', %q{
  Пользователью при регистрации должно приходить письмо с подвтерждением email-а.
  Пока пользователь не подтвердил email он не может стать разработчиком.
  Пока пользователь не подтвердил емайл ему выводится соответсвющая флешка, с ссылкой на повторную отправку письма.
}, :js => true do

  before do
    @user = FactoryGirl.create(:user)
  end

  scenario 'Пользователь подтверждает email после регистрации.' do
    capybara_sign_in_user @user
    @user.should_not be_activated

    find('#dashboard').click
    find('.new_confirm').click
    page.body.should have_content I18n.t('notice.email.confirmation_sent', email: @user.email)

    visit("/activate/#{@user.activation_token}")
    page.body.should have_content I18n.t('notice.email.confirmed')
  end

  after do
    @user.destroy
  end

end
