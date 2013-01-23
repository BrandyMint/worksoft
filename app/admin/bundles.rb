# -*- coding: utf-8 -*-
ActiveAdmin.register Bundle do
  decorate_with BundleDecorator

  filter :name
  filter :state, :as => :select, :collection => Bundle.state_machine.states.map( &:value )

  member_action :generate do
    bundle = Bundle.find params[:id]
    bundle.generate_bundle
    redirect_to admin_bundle_url(bundle)
  end

  member_action :activate do
    bundle = Bundle.find params[:id]
    bundle.publish!
    redirect_to admin_bundles_path
  end

  action_item :only => [:show, :edit] do
    link_to('Пересоздать пакет', generate_admin_bundle_path(bundle))
  end

  index do
    column :app do |bundle|
      link_to bundle.app, admin_app_path(bundle.app)
    end
    column :state
    column :state_mashine do |bundle|
      link_to "опубликовать", activate_admin_bundle_path(bundle.model) unless bundle.model.new?
    end
    column :source_file_link, :order => :source_file
    column :bundle_file_link, :order => :bundle_file
    column :version, :order => :version_number
    column :support

    default_actions
  end

  form :html => { :multipart => true } do |f|
    f.inputs do
      supported_list = []
      f.object.model.supported_configurations.each{|sc| supported_list << sc.configuration.name}
      f.input :version
      f.input :source_file, :as => :file, :hint => f.template.link_to("скачать", f.object.source_file.url)
      f.input :changelog
      f.input :supported_configurations, :collection => Configuration.all, 
        :hint => "Сейчас поддеживаются: #{supported_list.join(", ")}"
      # падает с ошибкой undefined method `persisted?' for #<ActiveSupport::SafeBuffer:0xb1ce0110>
      #f.has_many :supported_configurations do |form|
      #  form.input :configuration_id
      #end
    end

    f.inputs 'Ограничения' do
      f.input :supported_kernel_versions, :as => :string
    end

    f.buttons
  end

  show do |bundle|
    h1 bundle.name
    attributes_table do
      row :version
      row :support
      row :state
      row :icon do
        image_tag bundle.icon.url
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

  controller do
    def update
      supported_configs = params[:bundle][:supported_configuration_ids]
      if supported_configs.present? && !supported_configs.reject!{|v| v == ""}.empty?
        update_supported_configs supported_configs, params[:id]
      end
      params[:bundle].delete('supported_configuration_ids')

      super
    end

  private 

    def update_supported_configs incoming_config_ids, id
      bundle = Bundle.find id
      incoming_config_ids.reject!{|val| val.empty?}
      config_ids = bundle.supported_configurations.map(&:configuration_id)

      config_ids.each do |id|
        SupportedConfiguration.where(bundle_id: bundle.id, configuration_id: id).last.destroy unless  incoming_config_ids.include? id
      end
      incoming_config_ids.each do |id|
        SupportedConfiguration.create!(bundle_id: bundle.id, configuration_id: id) unless config_ids.include? id
      end
    end

  end
end
