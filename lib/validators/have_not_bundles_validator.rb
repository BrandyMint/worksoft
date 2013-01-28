# -*- coding: utf-8 -*-
class HaveNotBundlesValidator < ActiveModel::EachValidator
  def validate_each (record, attribute, value)
    unless record.bundles.empty?
      record.errors[attribute] << "Вы не можите изменять тип приложения, если у вас есть загруженные пакеты"
    end
  end
end
