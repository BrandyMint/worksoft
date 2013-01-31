# -*- coding: utf-8 -*-
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :developers, 'Разработчики', developers_path
  end
end
