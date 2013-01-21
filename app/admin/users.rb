# -*- coding: utf-8 -*-
ActiveAdmin.register User do
  index do
    column :id
    column :email
    column :activation_state
    
    default_actions  
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :developer_profile
    end
    
    f.buttons
  end
end
