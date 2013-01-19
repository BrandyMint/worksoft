# -*- coding: utf-8 -*-
require 'spec_helper'

describe App do
    before do
      @app = FactoryGirl.create(:app)
    end

    it do
      @app.state.should == "new"
    end

    context 'создаем bundle' do
      before do
        @bundle = FactoryGirl.create(:bundle, app: @app)
      end

      it 'автоматически публикует приложение при добавлении пакета' do
        @app.state.should == "ready"
        @app.active_bundle.should == @bundle
      end

      it 'устанавливает app state в :new, удаляет active_bundle' do
        @app.active_bundle.destroy
        @app.state.should == "new"
        @app.active_bundle.should be_nil
      end

    end

    after do
      @app.destroy
    end
end
