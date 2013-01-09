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

  # Сериализация в базу
  def version
    to_numeric
  end

  def to_s
    [major, minor, patch==0 ? nil : patch].compact.join('.')
  end

  def to_i
    major*Precision*Precision + minor*Precision + patch
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
