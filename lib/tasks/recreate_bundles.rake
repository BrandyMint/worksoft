# -*- coding: utf-8 -*-
namespace :worksoft do
  namespace :bundles do
    desc 'Пересоздает бандл файлы у всех активных bundle'
    task :recreate_bundles => :environment do
      Bundle.find_each {|bundle| bundle.update_bundle}
    end
  end
end
