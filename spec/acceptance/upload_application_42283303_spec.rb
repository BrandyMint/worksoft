# encoding: utf-8
require 'acceptance/acceptance_helper'

# https://www.pivotaltracker.com/story/show/42283303

feature 'Регистрация разработчика (создание профиля)', %q{
  Пользователь имеющий профиль разработчика идет по ссылке developer/apps/new
  Вводит название приложения, выбирает его тип, загружает лого и описание.
  Его перекидывает на страницу загрузки приложения (она же создания новой версии)
  Он выбирает загружаемый файл с *расширением не совпадающим с типом*, устанавливает поддерживаемые версии 1С и загружает приложение.
  Приложение не загружается, на экране выводится сообщение о неверном типе файла
  Разработчик повторяет пункт 4 но с верным типом файла.
  Приложение загружено, пакет сформирован и доступен к скачиванию

}, :js => true do

  before do
    @user = FactoryGirl.create(:developer)
    FactoryGirl.create(:kind)
    capybara_sign_in_user @user
  end

  scenario 'Будущий разработчик создает свой профиль' do
    # Пользователь имеющий профиль разработчика идет по ссылке developer/apps/new
    visit new_developer_app_path

    # Вводит название приложения, выбирает его тип, загружает лого и описание.
    #Его перекидывает на страницу загрузки приложения (она же создания новой версии)
    fill_in 'app_name', :with => 'Awsome report'
    select 'Отчет', :from => 'app_kind_id'
    attach_file 'app_icon', Rails.root + 'spec/fixtures/upic.gif'
    fill_in 'app_desc', :with => 'Очень крутое приложение.'
    find('.btn-primary').click
    current_path.should == new_developer_app_bundle_path(App.last)

    #Он выбирает загружаемый файл с *расширением не совпадающим с типом*, устанавливает поддерживаемые версии 1С и загружает приложение.
    #Приложение не загружается, на экране выводится сообщение о неверном типе файла
    fill_in 'bundle_supported_kernel_versions', :with => '7'
    attach_file 'bundle_source_file', Rails.root + 'spec/fixtures/upic.gif'
    find('.btn-primary').click
    page.body.should have_content "расширение файла .gif не совпадает с указаным типом приложения .#{App.last.kind.ext}"
    
    
    #Разработчик повторяет пункт подгружает нормальный файл.
    #Приложение загружено, пакет сформирован и доступен к скачиванию
    attach_file 'bundle_source_file', Rails.root + 'spec/fixtures/proceed.epf'
    find('.btn-primary').click
    page.body.should have_content "Загружена новая версия"
    page.body.should have_css('a.download_bundle')
  end

  after do
    @user.destroy
  end

end
