require 'spec_helper'

describe Developer::ProfileController do

  let!(:user) { FactoryGirl.create :user }

  before(:each) do
    controller.stub!(:current_user).and_return user
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create', :developer_profile => { :name => 'Name' }
      response.should be_redirect
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'update'" do
    it "returns http success" do
      user.activate!
      get 'update'
      response.should be_redirect
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      user.activate!
      FactoryGirl.create :developer_profile, :user => user
      get 'edit'
      response.should be_success
    end
  end

end
