# -*- coding: utf-8 -*-
ActiveAdmin.register DeveloperProfile do
  # decorate_with BundleDecorator
  form do |f|
    f.inputs do
      f.input :name
      f.input :avatar, :as => :file, :hint => f.template.image_tag(f.object.avatar.thumb_64.url)    
    end
    f.buttons
  end
end
