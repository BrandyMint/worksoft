# -*- coding: utf-8 -*-
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :apps, 'Приложения', apps_path
    primary.item :developers, 'Разработчики', developers_path
    primary.item :dashboard, 'Панель разработчика',
      developer_dashboard_path,
      :highlights_on => Proc.new { controller.is_a? Developer::BaseController }

    if logged_in?
      primary.item :profile, current_user, profile_path
      primary.item :logout, 'Выйти', logout_path, :method=>'delete'
    else
      primary.item :login, 'Войти', login_path
      primary.item :signup, 'Регистрация', new_user_path
    end
    primary.dom_class = 'nav pull-right'
  end
end