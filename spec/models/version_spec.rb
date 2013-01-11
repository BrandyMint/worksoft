# -*- coding: utf-8 -*-
require 'spec_helper'

describe Version do
  context "Парсинг версий из разных форматов" do
    it 'из строки' do
      v = Version.new '0.1.2'
      v.should == '0.1.2'
    end

    it 'из числа' do
      v = Version.new 10004
      v.should == '0.1.4'
    end

    it 'из массива' do
      v = Version.new [1,2,3]
      v.should == '1.2.3'
    end

    it 'в цифру и обратно'do
      v = Version.new '1.100.234'
      Version.new(v.to_i).should == v
    end
  end

  context 'плюшки' do
    it 'сокращает patch если он 0' do
      v = Version.new '0.1.0'
      v.to_s.should == '0.1'
    end

    it 'арифметика с версией' do
      v = Version.new '0.1.0'
      v.change(1,2,3).should == '1.3.3'
    end
  end
end
