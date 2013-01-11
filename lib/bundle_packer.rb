# -*- coding: utf-8 -*-
require 'tmpdir'
class BundlePacker
  attr_accessor :bundle

  def initialize bundle
    self.bundle = bundle
  end

  def generate
    puts dir
    # Пишем info.yaml
    IO.write info_file, bundle.spec.to_yaml

    # Копируем исходник
    FileUtils.copy bundle.source_file.file.file, app_file

    # Пакуем файлы
    #file = Archive::Zip.archive File.expand_path('public/',bundle_file), dir
    file = Archive::Zip.archive bundle_file, dir

    FileUtils.rm_rf dir

    # TODO Сохранять сразу в нужный каталог
    bundle.bundle_file.store! bundle_file
    bundle.save

    #bundle.write_attribute :bundle_file, bundle_file
    #bundle.save
  end

  private 

  def bundle_file
    #(Pathname.new(bundle.bundle_file.store_dir) + "#{bundle.bundle_file_name}.zip").to_s
    (Pathname.new(Dir.tmpdir) + "#{bundle.bundle_file_name}.zip").to_s
  end

  def info_file
    dir + 'info.yml'
  end

  def app_file
    dir + "app#{bundle.ext}"
  end

  def dir
    @dir ||= Pathname.new Dir.mktmpdir
  end

end