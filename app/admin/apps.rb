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
    column :active_bundle do |app|
      link_to app, admin_bundle_path(app.active_bundle) if app.active_bundle.present?
    end

    default_actions
  end

end
