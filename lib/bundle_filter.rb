class BundleFilter

  attr_accessor :user_system

  # Фильтрует массив бандлов по версии 1С и версии конфигурации из запроса (user_system)
  # а также пакует бандля по приложениям (выдает только последние версии бандлов)
  # для каждого приложения

  # user_system - AppSearchQuery
  #
  def initialize user_system
    raise 'must be a UserSystem' unless user_system.is_a? UserSystem

    @user_system = user_system
    @apps = {}
  end

  # Конвертирует app в bundle и фильтрует по запросу
  def apply bundles
    bundles.each do |b|
      # Отсеиваем бандлы у которых не подходящая версия ядря
      if user_system.kernel_version.present?
        next unless b.kernel_version_matchers.match user_system.kernel_version
      end

      # Отсеиваем бандля у которых не подходящая верси конфигурации
      # Именно версия, потому что саму конфигурацию мы отфильтровали на стадии
      # выборки через ransack
      if user_system.configuration_id.present? && user_system.configuration_version.present?
        next unless b.supported_configuration( user_system.configuration_id ).match user_system.configuration_version
      end

      add_to_apps b
    end

    bundles.where(id: @apps.values.map(&:id))
  end

  private

  def add_to_apps bundle
    # Сохраняем в app те версии bundles, которые наиболее поздние
    if @apps.has_key? bundle.app_id
      @apps[bundle.app_id] = bundle if @apps[bundle.app_id].version < bundle.version
    else
      @apps[bundle.app_id] = bundle
    end
  end

end
