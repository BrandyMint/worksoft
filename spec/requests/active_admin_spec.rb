require 'spec_helper'
require 'test_active_admin'
require 'acceptance/acceptance_helper'

# define active admin tests
test_active_admin do |config|

  config.before do
    # code to be executed before each resource test
    
  end

  config.login do
    # code to login to active admin
    @admin_user = FactoryGirl.create(:admin_user)
    visit '/admin'
    fill_in 'session_email', :with => @admin_user.email
    fill_in 'session_password', :with => '123456'
    find(".btn-primary").click
  end
end
