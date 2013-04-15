# encoding: utf-8

require 'acceptance/acceptance_helper'

feature '', js: true do
  before do
    @user = FactoryGirl.create(:developer)
    @kind = FactoryGirl.create(:kind)
    @supported_configuration = FactoryGirl.create(:supported_configuration)
    capybara_sign_in_user @user
  end

  scenario '' do
    visit new_developer_app_path
    fill_in 'app_name', :with => 'Awsome report'
    select 'Обработка', :from => 'app_kind_id'
    find('.btn-primary').click

    fill_in 'bundle_supported_kernel_versions', :with => '7'
    attach_file 'bundle_source_file', Rails.root + 'spec/fixtures/proceed.epf'
    find('.add_nested_fields').click
    find(:xpath, '(//select[starts-with(@name, "bundle[supported_configurations_attributes][new_")])[1]').find(:option, @supported_configuration.configuration.name).select_option
    find('.btn-primary').click

    find('.btn.btn-small.btn-success').click
    find('#bundle_version').value.should == '0.2'

    fill_in 'bundle_version', with: '0.1.1'
    attach_file 'bundle_source_file', Rails.root + 'spec/fixtures/proceed.epf'
    find('.btn-primary').click

    find('.btn.btn-small.btn-success').click
    find('#bundle_version').value.should == '0.1.2'

    fill_in 'bundle_version', with: '0.1.1.1'
    attach_file 'bundle_source_file', Rails.root + 'spec/fixtures/proceed.epf'
    find('.btn-primary').click

    find('.btn.btn-small.btn-success').click
    find('#bundle_version').value.should == '0.1.1.2'

    fill_in 'bundle_version', with: '1'
    attach_file 'bundle_source_file', Rails.root + 'spec/fixtures/proceed.epf'
    find('.btn-primary').click

    find('.btn.btn-small.btn-success').click
    find('#bundle_version').value.should == '2.0'
  end

  after do
    @supported_configuration.destroy
    @kind.destroy
    @user.destroy
  end
end