# -*- coding: utf-8 -*-
# ValueObject для версий
class Version
  include Comparable
  Precision = 10000
  attr_accessor :major, :minor, :patch

  def initialize value
    if value.is_a? Array
      from_array value
    elsif value.is_a? String
      from_str value
    elsif value.is_a? Fixnum
      from_fixnum value
    elsif value.is_a? Version
      self.major = value.major
      self.minor = value.minor
      self.patch = value.patch
    #elsif value.is_a? NilClass
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

  def to_s
    [major, minor, patch==0 ? nil : patch].compact.join('.')
  end

  # Сериализация
  def version
    to_i
  end

  def to_i
    major*Precision*Precision + minor*Precision + patch
  end

  # Возвращает новый Version с изменениями из параметров
  #
  def change mjd, mid=0, pd=0
    Version.new [major+mjd, minor+mid, pd]
  end

  def next
    change 0, 1
  end

  private

  def from_fixnum value
    @major = value / (Precision * Precision) % Precision
    @minor = value / Precision % Precision
    @patch = value % Precision
  end

  def from_array value
    raise "Слишком большая длинна #{value.length} массива #{value}" if value.length>3
    @major, @minor, @patch = value

    @major||=0
    @minor||=0
    @patch||=0
  end
  
  def from_str str
    from_array str.split('.').map &:to_i
  end
end