# -*- coding: utf-8 -*-
ActiveAdmin.register Bundle do
  # decorate_with BundleDecorator
  #
  FIELDS = [:name, :version, :supported_kernel_versions ]

  filter :name
  filter :state, :as => :select, :collection => Bundle.state_machine.states.map( &:value )

  member_action :generate do
    bundle = Bundle.find params[:id]
    bundle.generate_bundle
    redirect_to admin_bundle_url(bundle)
  end

  action_item :only => [:show, :edit] do
    link_to('Пересоздать пакет', generate_admin_bundle_path(bundle))
  end

  index do
    column :app do |bundle|
      link_to bundle.app, admin_app_path(bundle.app)
    end
    FIELDS.each do |a|
      column a
    end

    default_actions
  end

  form :html => { :multipart => true } do |f|
    f.inputs do
      f.input :name
      f.input :state, :collection => Bundle.state_machine.states.map( &:value )
      f.input :version_str
      f.input :source_file, :as => :file
      f.input :icon, :as => :file
    end

    f.inputs 'Ограничения' do
      f.input :supported_kernel_versions
      #f.input :versionconf
      #f.input :nameconf
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
      row :uuid
    end

    active_admin_comments
  end
end
