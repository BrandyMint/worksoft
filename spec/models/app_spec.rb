# -*- coding: utf-8 -*-
require 'spec_helper'

describe App do
    before do
      @app = FactoryGirl.create(:app)
      @bundle = FactoryGirl.create(:bundle, app: @app)
    end

    it 'устанавливает app state в :ready, устанавливает текущий active_bundle' do
      @app.state.should == "new"
      @bundle.publish
      @app.state.should == "ready"
      @app.active_bundle.should == @bundle
    end

    it 'обновляет active_bundle' do
      bundle = FactoryGirl.create(:bundle, app: @app)
      bundle.publish
      @app.state.should == "ready"
      @app.active_bundle.should == bundle
    end

    it 'устанавливает app state в :new, удаляет active_bundle' do
      @bundle.destroy
      @app.state.should == "new"
      @app.active_bundle.should be_nil
    end

    after do
      @app.destroy
    end
end
