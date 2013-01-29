#-*- coding:utf-8 -*-
require 'spec_helper'

describe Developer::BundlesController do
  before do
    @user = FactoryGirl.create(:developer)
    @app  = FactoryGirl.create(:app, developer_profile: @user.developer_profile)
    login_user @user 
  end

  it 'открывает форму загрузки нового bundle' do
    get :new, :app_id => @app.id
    response.should be_success
  end

  it 'создает новый bundle при передаче в контроллер всех возможных параметров' do
    FactoryGirl.create(:configuration)
    FactoryGirl.create(:configuration)
    get :create, {:app_id => @app.id,  :bundle => {
      "version" => "0.1.3", 
      "source_file" => ActionDispatch::Http::UploadedFile.new(
      :tempfile => File.new(Rails.root.join("spec/fixtures/proceed.epf")),
      :filename => File.basename(File.new(Rails.root.join("spec/fixtures/proceed.epf")))
    ), 
      "supported_kernel_versions" => "7.0", 
      "supported_configurations_attributes" => {
        "0" => {"configuration_id" => "2", "versions" => "1.2", "_destroy" => "false"}, 
        "1" => {"configuration_id" => "1", "versions" => "", "_destroy" => "false"}},
      "changelog"=>"изменения"}}
    response.should redirect_to developer_app_path(@app)
    @app.bundles(true)
    @app.bundles.last.should be_persisted
  end
  

  after do
    @user.destroy
    @app.destroy  
  end
end
