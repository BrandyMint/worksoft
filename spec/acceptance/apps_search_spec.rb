# encoding: utf-8

require 'acceptance/acceptance_helper'

feature 'Поиск приложений', js: true do
  before do
    @app = FactoryGirl.create(:app, name: 'Detailed report')
    @bundle = FactoryGirl.create(:bundle, app: @app)
    @app2 = FactoryGirl.create(:app, name: 'Detailed reference')
    @bundle2 = FactoryGirl.create(:bundle, app: @app2)
  end

  scenario 'по названию' do
    visit root_path
    fill_in 'app_search_query_name', with: 'report'
    find('.btn-primary').click
    find('.apps-list').should have_content @app.name
    find('.apps-list').should_not have_content @app2.name
  end

  scenario 'по конфигурации пользователя' do
    visit new_user_system_path
    fill_in 'user_system_kernel_version', with: '8.0'
    select @bundle.supported_configurations.first.configuration.name, from: 'user_system_configuration_id'
    fill_in 'user_system_configuration_version', with: '1.2.3.4'
    find('.btn-primary').click
    fill_in 'app_search_query_name', with: 'Detailed'
    find('.btn-primary').click
    find('.apps-list').should have_content @app.name
    find('.apps-list').should_not have_content @app2.name
  end

  after do
    @bundle2.destroy
    @app2.destroy
    @bundle.destroy
    @app.destroy
  end
end
