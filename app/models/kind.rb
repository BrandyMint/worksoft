# -*- coding: utf-8 -*-
class Kind < ActiveRecord::Base
  attr_accessible :title, :ext

  has_many :apps

  def to_s
    title
  end
end
