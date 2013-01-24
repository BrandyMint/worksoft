# -*- coding: utf-8 -*-

module AppBundleDefaultsExtension
  def build attrs = {}, *args
    app = @association.owner
    if app.last_bundle.present?
      attrs.reverse_merge!(
        :version => app.last_bundle.version.next,
        :supported_kernel_versions => app.last_bundle.supported_kernel_versions,
        :supported_configurations_attributes =>
        app.last_bundle.supported_configurations.map do |sc|
          { :configuration_id => sc.configuration_id,
            :version => sc.version }
        end
      )
    else
      attrs.reverse_merge! :version => Version.new( '0.1' )
    end

    super attrs, *args
  end
end

