class OpenBill::Transaction < Sequel::Model(:openbill_transactions)
  many_to_one :account
end
