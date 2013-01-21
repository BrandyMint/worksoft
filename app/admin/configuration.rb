# -*- coding: utf-8 -*-
ActiveAdmin.register Configuration do
  # decorate_with BundleDecorator
  #
  index do
    column :name

    default_actions
  end

  form do |f|
    f.inputs do
      f.input :name
    end

    f.buttons
  end

end
