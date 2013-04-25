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
  def perform(bundles)
    if user_system && user_system.complete?
      configuration = user_system.configuration
      configuration_version = user_system.configuration_version
      kernel_version = user_system.kernel_version

      bundles = bundles.joins(:supported_configurations).
        where("supported_configurations.configuration_id = #{user_system.configuration_id} or supported_configurations.configuration_id is null")

      bundles.each do |bundle|
        # Отсеиваем бандлы у которых не подходящая версия ядря
        next unless bundle.kernel_version_matchers.match(kernel_version)
        # Отсеиваем бандлы у которых не подходящая верси конфигурации
        # Именно версия, потому что саму конфигурацию мы отфильтровали на стадии
        # выборки через ransack
        next unless bundle.supported_configuration(configuration).match(configuration_version)
        add_to_apps(bundle)
      end
    else
      bundles.each do |bundle|
        add_to_apps(bundle)
      end
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
