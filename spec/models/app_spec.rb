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
        @app.current_bundle.should == @bundle
      end

      it 'устанавливает app state в :new, удаляет current_bundle' do
        @app.current_bundle.set_destroy
        @app.state.should == "new"
        @app.current_bundle.should be_nil
      end
    end

    context 'обновление приложения' do
      before do
        FactoryGirl.create(:bundle, app: @app)
      end
      
      it 'обновляет bundle_file при обновлении приложения' do
        pending "в разработке"
        @app.bundles(true)

        @app.current_bundle.should_receive :update_bundle
        @app.update_attribute :name, "another name"
      end

      it 'обновляет kind приложения, если у него нет ни одного bundle' do
        kind = FactoryGirl.create(:kind)
        @app.stub(:bundles) {[]}
        @app.update_attributes({:kind_id => kind.id}).should be_true
      end

      it 'не обновляет kind приложения, если у него есть хотя бы один bundle' do
        @app.update_attributes({:kind_id => 3}).should be_false
      end


      after do
        Bundle.last.destroy      
      end
    end

    after do
      @app.destroy
    end
end
