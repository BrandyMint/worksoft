# -*- coding: utf-8 -*-
module ApplicationHelper
  include BootstrapHelper

  def kindes_collection_for_search
    [['Любой тип', nil]] + Kind.all.map { |k| [k.to_s, k.id]}
  end

  def span text
    content_tag :span, text
  end

  def icon *classes
    css = classes.map{|c| "icon-#{c}"}.join(' ')
    content_tag :i, '', :class => "icon #{css}"
  end

  def counter count
    count>0 ? "(#{count})" : ''
  end

  def state_label object
    k = {'new' =>  'label-warning', 'ready' => 'label-success' }
    content_tag :span, object.human_state_name, :class => "label #{k[object.state]}"
  end

  def developer_profile
    current_user.developer_profile
  end
end
