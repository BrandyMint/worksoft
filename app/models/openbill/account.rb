class OpenBill::Account < Sequel::Model(:openbill_accounts)
  one_to_many :transactions, :key => :to_account_id
  one_to_many :out_transactions, :key => :from_account_id

end
