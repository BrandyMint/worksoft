require 'spec_helper'

describe UserSessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      pending
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      pending
      get 'destroy'
      response.should be_success
    end
  end

end
