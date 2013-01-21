# -*- coding: utf-8 -*-
ActiveAdmin.register Role do
  index do
    column :id
    column :name
    column :resource_type
    
    default_actions  
  end 
end
