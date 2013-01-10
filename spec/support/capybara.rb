#encoding: utf-8
def capybara_sign_in_user user
  visit '/login'
  fill_in 'session_email', :with => user.email
  fill_in 'session_password', :with => '123456'
  find(".btn-primary").click
end
