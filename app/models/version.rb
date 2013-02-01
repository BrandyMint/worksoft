# -*- coding: utf-8 -*-
# ValueObject для версий
class Version
  include Comparable
  Precision = 10000
  attr_accessor :major, :minor, :patch, :build

  def initialize value
    if value.is_a? Array
      from_array value
    elsif value.is_a? String
      from_str value
    elsif value.is_a? Bignum or value.is_a? Fixnum 
      from_fixnum value
    elsif value.is_a? Version
      self.major = value.major
      self.minor = value.minor
      self.patch = value.patch
      self.build = value.build
    elsif value.is_a? NilClass
      self.major = nil
      self.minor = nil
      self.patch = nil
      self.build = nil
    else
      raise "Unknown type #{value.class} of #{value}"
    end
  end

  def <=>(anOther)
    to_i <=> anOther.to_i
  end

  def == anOther
    anOther = Version.new(anOther) unless anOther.is_a? Version
    anOther.to_i == to_i
  end

  def present?
    !to_s.blank?
  end

  def to_s
    if major.nil?
      ''
    else
      [major,
      minor,
      patch == 0 ? nil : patch,
      build == 0 ? nil : build
      ].compact.join('.')
    end
  end

  # Сериализация
  def version
    to_i
  end

  def to_i
    if major.nil?
      nil
    else
      major*Precision*Precision*Precision + minor*Precision*Precision + patch*Precision + build
    end
  end

  # Возвращает новый Version с изменениями из параметров
  #
  def change mjd, mid = 0, pt = 0, bd = 0
    Version.new [ major + mjd, minor + mid, patch + pt, build + bd ]
  end

  def next
    change 0, 0, 1, 0
  end

  private

  def from_fixnum value
    if value == 0
      @major = nil
      @minor = nil
      @patch = nil
      @build = nil
    else
      @major = value / (Precision * Precision * Precision) % Precision
      @minor = value / (Precision * Precision) % Precision
      @patch = value / Precision % Precision
      @build = value % Precision
    end
  end

  def from_array value
    raise "Слишком большая длинна #{value.length} массива #{value}" if value.length > 4
    value.each {|ver| raise "Слишком большое значение версии #{value}" if ver > 999}

    @major, @minor, @patch, @build = value

    @major||=0
    @minor||=0
    @patch||=0
    @build||=0
  end
  
  def from_str str
    from_array str.split('.').map &:to_i
  end
end
