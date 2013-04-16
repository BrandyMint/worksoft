# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

  #include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    asset_path "fallback/app/#{version_name}.png"
  end

  # Create different versions of your uploaded files:
  version :thumb_64 do
    process :resize_to_fit => [64, 64]
  end

  version :thumb_48 do
    process :resize_to_fit => [48, 48]
  end

  version :thumb_24 do
    process :resize_to_fit => [24, 24]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  #def url
    #super_result = super
    #File.join(Settings.asset_host, super_result) if super_result
  #end

  #def persistence_url
    #"#{Settings.url}/api/v1/users/#{model.id}/image"
  #end

end
