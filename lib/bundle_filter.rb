class BundleFilter

  attr_accessor :q

  # Фильтрует массив бандлов по версии 1С и версии конфигурации из запроса (q)
  # а также пакует бандля по приложениям (выдает только последние версии бандлов)
  # для каждого приложения

  # q - AppSearchQuery
  def initialize q
    raise 'must be AppSearchQuery' unless q.is_a? AppSearchQuery

    @q = q
    @apps = {}
  end

  # Конвертирует app в bundle и фильтрует по запросу
  def apply bundles
    bundles.each do |b|
      # Отсеиваем бандлы у которых не подходящая версия ядря
      if q.kernel_version.present?
        next unless b.kernel_version_matchers.match q.kernel_version
      end

      # Отсеиваем бандля у которых не подходящая верси конфигурации
      # Именно версия, потому что саму конфигурацию мы отфильтровали на стадии
      # выборки через ransack
      if q.configuration_id.present? && q.configuration_version.present?
        next unless b.supported_configuration( q.configuration_id ).match q.configuration_version
      end

      add_to_apps b
    end

    @apps
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
