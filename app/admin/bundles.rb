# -*- coding: utf-8 -*-
ActiveAdmin.register Bundle do
  # decorate_with BundleDecorator
  #
  FIELDS = [:name, :version, :version1c, :versionconf, :nameconf ]

  index do
    FIELDS.each do |a|
      column a
    end

    default_actions
  end

  form :html => { :multipart => true } do |f|
    f.inputs do
      f.input :name
      f.input :version
      f.input :file, :as => :file
    end

    f.inputs 'Ограничения' do
      f.input :version1c
      f.input :versionconf
      f.input :nameconf
    end

    f.inputs do
      f.input :desc
    end

    f.buttons
  end

  show do |bundle|
    h1 bundle.name
    attributes_table do
      FIELDS.map { |f| row f}
      row :file do
        # image_tag(ad.image.url)
        link_to bundle.file, bundle.file.url
      end

      row :desc
    end

    active_admin_comments
  end
end
