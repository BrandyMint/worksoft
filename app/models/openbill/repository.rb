class OpenBill::Repository

  def self.connect
    #DB = Sequel.connect('postgres://user:password@host:port/database_name')
    #DB = Sequel.postgres('database_name', :user=>'user', 
    #       :password=>'password', :host=>'host', :port=>5432, 
    #              :max_connections=>10))
    #or Sequel::Model.db=
    @db ||= Sequel.postgres 'worksoft_develop', :port => 5433
    Sequel::Model.db = @db
  end

  def self.balance
    OpenBill::Account.sum(:balance)
  end

  def self.create_transaction attrs
    raise unless attrs[:amount]>0
    raise unless attrs[:details]
    Sequel::Model.db.transaction do
      account_from = attrs[:from_account] || OpenBill::Account[attrs[:from_account_id]]
      account_to   = attrs[:to_account] || OpenBill::Account[attrs[:to_account_id]]

      OpenBill::Account.dataset.where(:id=>account_from.id).
        update("balance=balance-#{attrs[:amount]}")

      OpenBill::Account.dataset.where(:id=>account_to.id).
        update("balance=balance+#{attrs[:amount]}")

      OpenBill::Transaction.create :from_account_id => account_from.id,
      :to_account_id => account_to.id,
      :amount => attrs[:amount],
      :details => attrs[:details]
    end
  end

end
