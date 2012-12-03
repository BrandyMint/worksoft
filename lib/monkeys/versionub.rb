# -*- coding: utf-8 -*-
module Versionub
  Precision = 10000

  def self.from_numeric num
    parse pull_value num
  end

  def self.pull_value num, str=''
    return num.to_s << str if num < Precision

    v = num % Precision
    num = num / Precision

    pull_value num, ".#{v}"+str
  end

end

class Versionub::Type::Instance
  MaximumValues = 4

  # Преобразует версию в одно большое число
  # которое можно хранить в базе, сортировать и индиксировать
  #
  def to_numeric
    arr = to_s.split('.').map &:to_i

    raise "больше #{MaximumValues}-х нельзя" if arr.size>MaximumValues

    self.class.value_incapsulator 0, arr
  end

  private

  def self.value_incapsulator value=0, arr
    return value if arr.empty?

    next_value = arr.shift
    raise "значение версии #{next_value} больше допустимого #{Versionub::Precision}" if next_value>=Versionub::Precision

    value_incapsulator (value*Versionub::Precision+next_value), arr
  end

end
