class DeveloperBundle < SimpleDelegator
  attr_accessor :app

  def initialize app, bundle
    @app = app
    super bundle
  end

  def self.model_name
    ActiveModel::Name.new self, nil, 'developer_bundle'
    #ActiveModel::Name.new(Feed)
  end

  def to_model
    self
  end

end
