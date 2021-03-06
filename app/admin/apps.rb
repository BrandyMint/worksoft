# -*- coding: utf-8 -*-
ActiveAdmin.register App do
  # decorate_with BundleDecorator

  index do
    column :id
    column :icon do |app|
      image_tag app.icon.thumb_48.url
    end
    column :state do |app|
      state_label app
    end
    column :developer_profile do |app|
      link_to app, admin_developer_profile_path(app.developer_profile)
    end
    column :current_bundle do |app|
      link_to app, admin_bundle_path(app.current_bundle) if app.current_bundle.present?
    end

    default_actions
  end

  form do |f|
    f.inputs do
      f.input :name 
      f.input :kind
      f.input :desc
      f.input :icon, :as => :file, :hint => f.template.image_tag(f.object.icon.thumb_64.url) 
      f.buttons
    end
  end
end
