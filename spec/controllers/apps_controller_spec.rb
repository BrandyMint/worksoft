require 'spec_helper'

describe AppsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      app = FactoryGirl.create :app
      get 'show', :id => app.id
      response.should be_success
    end
  end

end
