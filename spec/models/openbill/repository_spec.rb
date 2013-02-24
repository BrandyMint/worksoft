# -*- coding: utf-8 -*-
require 'spec_helper'

require 'openbill'

describe OpenBill::Repository do
  before :all do
    @account1 = OpenBill::Account.create :user_key => 'User 1'
    @account2 = OpenBill::Account.create :user_key => 'User 2'
    OpenBill::Transaction.delete
  end

  specify 'Счета пусты по началу' do
    @account1.balance.should == 0.0
    @account2.balance.should == 0.0
    OpenBill::Repository.balance.to_f == 0.0
  end

  context "Перечисляем с первого счета на второй 100 рублей 50 копеек" do
    before :all do
      OpenBill::Repository.create_transaction :from_account => @account1, :to_account => @account2,
        :amount => 100.50, :details => 'Тестовый платеж'
      @account1.reload
      @account2.reload
    end

    specify 'С первого счета списано, на второй зачислено' do
      @account1.balance.should == -100.50
    end

    specify 'С первого счета списано, на второй зачислено' do
      @account2.balance.should == 100.50
    end

    specify 'Баланс системы в норме' do
      OpenBill::Repository.balance.to_f == 0.0
    end

    specify 'В базе есть одна транзакция' do
      OpenBill::Transaction.count.should == 1
    end
  end

  after :all do
    OpenBill::Transaction.delete
    @account1.destroy
    @account2.destroy
  end

end
