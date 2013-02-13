# -*- coding: utf-8 -*-
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|

    if logged_in?
      primary.item :dashboard, 'Панель разработчика',
        developer_dashboard_path,
        :highlights_on => Proc.new { controller.is_a? Developer::BaseController },
        :if => Proc.new { current_user.developer? }

      primary.item :profile, gravatar_image_tag(@user.email, :size => 30, :gravatar => { :default => 'https://assets.github.com/images/gravatars/gravatar-140.png', :size => 40 }), profile_path
      primary.item :logout, 'Выйти', logout_path, :method=>'delete'
    else
      primary.item :login, 'Войти', login_path
      primary.item :signup, 'Регистрация', new_user_path
    end
    primary.dom_class = 'nav pull-right'
  end
end
