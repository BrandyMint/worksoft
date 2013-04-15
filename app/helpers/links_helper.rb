# -*- coding: utf-8 -*-
module LinksHelper
  def developer_link developer_profile
    link_to  developer_url(developer_profile), :class => 'developer_link' do
      icon(:certificate) << developer_profile.name
    end
  end

  def upload_bundle_link app
    link_to new_developer_app_bundle_path(app), :class => 'btn btn-small btn-success' do
      icon(:white, :hdd) << ' Загрузить новую версию'
    end
  end

  def destroy_bundle_link bundle
    link_to developer_app_bundle_path(bundle.app, bundle), :method => :delete, :class => 'btn btn-small btn-danger' do
      icon(:trash, :white) << ' Удалить'
    end
  end

  def edit_app_link app, css=''
    link_to edit_developer_app_path(app), :class => "btn btn-small #{css}" do
      icon(:edit) << ' Настройка'
    end
  end

  def download_link bundle
    file = bundle.bundle_file
    link_to file.url, :class => 'btn btn-small download-link' do
      fontello('download','14','v-align-baseline') << " Скачать<br>(#{number_to_human_size file.file_size})".html_safe
    end
  end
end
