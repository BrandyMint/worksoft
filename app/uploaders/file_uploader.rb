# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def ensure_multipart_form
    false
  end

  #def url
    ## Это чтобы рельсы нормально отрабатывали калькулируемый asset_host
    ## не получается использовать так как не вышло подключить сюда хелпер
    ## image_path(super)
    ##
    ## TODO Важно выдавать в письмах полный url чтобы эти ссылки работали из писем
    #super_result = super
    #File.join(Settings.asset_host, super_result) if super_result
    ##
  #end

  def mime_type
    ::MIME::Types.type_for(file.original_filename).first.to_s
  end

  def file_size
    File.size(file.file.to_s)
  rescue StandardError
    0
  end

end
