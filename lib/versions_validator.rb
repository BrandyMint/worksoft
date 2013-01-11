# -*- coding: utf-8 -*-
class VersionsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    matchers = VersionMatchers.new value
    record.send "#{attribute}=", matchers.to_s
  rescue StandardError => e
    Rails.logger.error e.inspect
    Rails.logger.error e.backtrace
    record.errors.add(attribute, "Список поддерживаемых версий имеет неверный формат #{e}") if e.message
  end
end
