# encoding: utf-8
require 'acceptance/acceptance_helper'

# https://www.pivotaltracker.com/story/show/42283023

feature 'Регистрация разработчика (создание профиля)', %q{
  После регистрации пользователь не активирован.
  Пока пользователь не подтвердил email он не может стать разработчиком.
  Пока пользователь не подтвердил емайл ему выводится соответсвющая флешка, с ссылкой на повторную отправку письма.
}, :js => true do

  before do
    @user = FactoryGirl.create(:user)
  end

  scenario 'Пользователь подтверждает email после регистрации.' do
    capybara_sign_in_user @user

    # Пока пользователь не подтвердил емайл, ему выводится соответсвющая флешка, с ссылкой на повторную отправку письма.
    find('#dashboard').click
    page.body.should have_content ActionController::Base.helpers.strip_tags(I18n.t('notice.email.need_confirm'))

    # Пользователь запрашивает новое письмо для активации.
    find('.new_confirm').click
    page.body.should have_content I18n.t('notice.email.confirmation_sent', email: @user.email)

    # После того как пользователь прошел по ссылке активации он становится активным.
    visit(activate_user_path(token: @user.activation_token))
    page.body.should have_content I18n.t('notice.email.confirmed')
  end

  after do
    @user.destroy
  end

end
