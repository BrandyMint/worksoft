# -*- coding: utf-8 -*-
require 'spec_helper'

describe Version do
  context "Парсинг версий из разных форматов" do
    it 'из строки' do
      v = Version.new '0.1.2.5'
      v.should == '0.1.2.5'
    end

    it 'из числа' do
      v = Version.new 1000500010003
      v.should == '1.5.1.3'
    end

    it 'из массива' do
      v = Version.new [1,2,3,4]
      v.should == '1.2.3.4'
    end

    it 'в цифру и обратно'do
      v = Version.new '1.100.234.3'
      Version.new(v.to_i).should == v
    end
  end

  context 'плюшки' do
    it 'сокращает major_patch если он 0' do
      v = Version.new '0.1.0'
      v.to_s.should == '0.1'
    end

    it 'сокращает major_patch и minor_patch если они равны 0' do
      v = Version.new '0.1.0.0'
      v.to_s.should == '0.1'
    end

    it 'арифметика с версией' do
      v = Version.new '0.1.0.7'
      v.change(1,2,3,1).should == '1.3.3.8'
    end
  end
end
