# -*- coding: utf-8 -*-
class SupportedConfigurationsValidator < ActiveModel::Validator
  def validate record

    unless record.supported_configurations.any?
      record.errors[:base] << "У пакета должна быть хотябы одна поддерживаемая конфигурация"
    end
  end
end
