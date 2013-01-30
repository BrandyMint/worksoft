# -*- coding: utf-8 -*-

FactoryGirl.define do
  sequence :conf_name do |n|
    "БухгалтеряПредприятия_#{n}"  
  end

  factory :configuration do
    name {generate(:conf_name)}
  end
end
