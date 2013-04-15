# -*- coding: utf-8 -*-
require 'spec_helper'

describe Bundle do
  before do
    @app = FactoryGirl.create(:app)
    @app.kind.stub(:ext) {'epf'}
  end

  it 'не валидный, если расширение загружаемого файла отличается от указанного в приложении' do
    bundle = Bundle.new(
              source_file: Rack::Test::UploadedFile.new('spec/fixtures/upic.gif', 'image/gif'),
              app: @app,
              supported_kernel_versions: "7.0")
    bundle.should_not be_valid
  end

  it 'валидный, если расширение загружаемого файла соответствует указанному в приложении' do
    bundle = Bundle.new(
        source_file: Rack::Test::UploadedFile.new('spec/fixtures/proceed.epf', 'file/epf'),
        app: @app,
        supported_kernel_versions: "7.0",
        supported_configurations_attributes: [configuration_id: 1]
    )
    bundle.should be_valid
  end

  after do
    @app.destroy
  end
end
