# -*- coding: utf-8 -*-
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :bundles, 'Пакеты', bundles_path
    primary.item :dashboard, 'Панель разработчика', developer_dashboard_path

    if logged_in?
      primary.item :logout, 'Выйти', logout_path, :method=>'delete'
      #primary.item :sign_up, t('devise.common.sign_up'), new_user_registration_path
      #primary.item :sign_in, t('devise.common.sign_in'), new_user_session_path
    end
    primary.dom_class = 'nav pull-right'
  end
end
