# -*- coding: utf-8 -*-
ActiveAdmin.register Bundle do
  # decorate_with BundleDecorator
  #
  FIELDS = [:name, :version, :version1c, :versionconf, :nameconf, :icon ]

  filter :name
  filter :state, :as => :select, :collection => Bundle.state_machine.states.map( &:value )

  index do
    FIELDS.each do |a|
      column a
    end

    default_actions
  end

  form :html => { :multipart => true } do |f|
    f.inputs do
      f.input :name
      f.input :state, :collection => Bundle.state_machine.states.map( &:value )
      f.input :version
      f.input :source_file, :as => :file
      f.input :icon, :as => :file
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
      row :icon do
        image_tag bundle.icon.url if bundle.icon?
      end

      row :source_file do
        link_to bundle.source_file, bundle.source_file.url
      end

      row :bundle_file do
        link_to bundle.bundle_file, bundle.bundle_file.url
      end

      row :desc
    end

    active_admin_comments
  end
end
