#encoding: utf-8
def capybara_sign_in_user user, password='123456'
  visit '/login'
  fill_in 'session_email', :with => user.email
  fill_in 'session_password', :with => password
  find(".btn-primary").click
end
