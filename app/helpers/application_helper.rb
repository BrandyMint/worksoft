# -*- coding: utf-8 -*-
module ApplicationHelper
  include BootstrapHelper

  def state_label object
    k = {'new' =>  'label-warning'}
    content_tag :span, object.human_state_name, :class => "label #{k[object.state]}"
  end

  def edit_link_to url
    link_to url, :class => 'action-link' do
      content_tag( :i, '', :class => 'icon icon-edit' ) <<
      content_tag( :span, ' изменить' )
    end
  end

  def developer_profile
    current_user.developer_profile
  end
end
