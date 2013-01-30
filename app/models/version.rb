# -*- coding: utf-8 -*-
# ValueObject для версий
class Version
  include Comparable
  Precision = 10000
  attr_accessor :major, :minor, :major_patch, :minor_patch

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
      self.major_patch = value.major_patch
      self.minor_patch = value.minor_patch
    elsif value.is_a? NilClass
      self.major = nil
      self.minor = nil
      self.major_patch = nil
      self.minor_patch = nil
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
    if major.nil?
      ''
    else
      [major,
      minor,
      major_patch == 0 ? nil : major_patch,
      minor_patch == 0 ? nil : minor_patch
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
      major*Precision*Precision*Precision + minor*Precision*Precision + major_patch*Precision + minor_patch
    end
  end

  # Возвращает новый Version с изменениями из параметров
  #
  def change mjd, mid=0, mj_pd=0, mn_pd = 0
    Version.new [major+mjd, minor+mid, major_patch+mj_pd, minor_patch+mn_pd]
  end

  def next
    change 0, 0, 0, 1
  end

  private

  def from_fixnum value
    if value == 0
      @major = nil
      @minor = nil
      @major_patch = nil
      @minor_patch = nil
    else
      @major = value / (Precision * Precision * Precision) % Precision
      @minor = value / (Precision * Precision) % Precision
      @major_patch = value / Precision % Precision
      @minor_patch = value % Precision
    end
  end

  def from_array value
    raise "Слишком большая длинна #{value.length} массива #{value}" if value.length > 4
    value.each {|ver| raise "Слишком большое значение версии #{value}" if ver > 999}

    @major, @minor, @major_patch, @minor_patch = value

    @major||=0
    @minor||=0
    @major_patch||=0
    @minor_patch||=0
  end
  
  def from_str str
    from_array str.split('.').map &:to_i
  end
end
