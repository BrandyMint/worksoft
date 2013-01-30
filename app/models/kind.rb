# -*- coding: utf-8 -*-
class Kind < ActiveRecord::Base
  attr_accessible :title, :ext

  has_many :apps

  def to_s
    title
  end

  
  def kind_type
    {
      "Обработка" => "epf", 
      "Обработка ТЧ (табличной части)" => "epftab", 
      "Печатная форма" => "epfprint", 
      "Отчет" => "erf"
    }[title]
  end

end
