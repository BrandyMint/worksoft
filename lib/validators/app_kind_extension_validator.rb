# -*- coding: utf-8 -*-
class AppKindExtensionValidator < ActiveModel::EachValidator
  def validate_each (record, attribute, value)
    if record.source_file.present?
      file_ext = record.source_file.file.extension.downcase 
      app_file_ext = record.app.kind.ext
      record.errors[attribute] << "расширение файла .#{file_ext} не совпадает с указаным типом приложения .#{app_file_ext}" if  file_ext != app_file_ext
    end  
  end
end
