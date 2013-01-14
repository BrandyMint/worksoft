class BundleDecorator < Draper::Base
  decorates :bundle

  def file
    link_to bundle.name, bundle.bundle_file
  end

  def source_file_link
    h.link_to bundle.source_file.file.filename, bundle.source_file.url
  end

  def bundle_file_link
    h.link_to bundle.bundle_file.file.filename, bundle.bundle_file.url
  end

  def state
    h.state_label bundle
  end

  def supported_kernel_version
    content_tag(:div, bundle.supported_kernel_versions)
  end

  def support
    (supported_kernel_versions.to_s << supported_configurations.to_s).html_safe
  end

  def supported_configurations
    h.content_tag :div do
      h.content_tag :small, :class => :muted do
        bundle.supported_configurations.map(&:configuration).join(', ')
      end
    end
  end

  # Accessing Helpers
  #   You can access any helper via a proxy
  #
  #   Normal Usage: helpers.number_to_currency(2)
  #   Abbreviated : h.number_to_currency(2)
  #
  #   Or, optionally enable "lazy helpers" by including this module:
  #     include Draper::LazyHelpers
  #   Then use the helpers with no proxy:
  #     number_to_currency(2)

  # Defining an Interface
  #   Control access to the wrapped subject's methods using one of the following:
  #
  #   To allow only the listed methods (whitelist):
  #     allows :method1, :method2
  #
  #   To allow everything except the listed methods (blacklist):
  #     denies :method1, :method2

  # Presentation Methods
  #   Define your own instance methods, even overriding accessors
  #   generated by ActiveRecord:
  #
  #   def created_at
  #     h.content_tag :span, attributes["created_at"].strftime("%a %m/%d/%y"),
  #                   :class => 'timestamp'
  #   end
end
