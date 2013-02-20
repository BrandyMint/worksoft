class Configuration < ActiveRecord::Base
  attr_accessible :name

  has_many :supported_configurations

  scope :ordered, order(:name)

  validates :name, :presence => true, :uniqueness => true

  def to_s
    title
  end

  def title
    name # Ставить пробелы перед заглавными
  end
end
