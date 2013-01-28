# -*- coding: utf-8 -*-
ActiveAdmin.register Role do
  actions :index

  index do
    column :id
    column :name
    column :resource_type
    
    default_actions  
  end
end
