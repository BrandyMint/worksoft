class CreateOpenbillTables < ActiveRecord::Migration
  def change
    create_table :openbill_accounts do |t|
      t.decimal  :balance, :null => false, :default => 0, :precision => 12, :scale => 2
      t.string   :user_key, :null => false
      t.timestamps
    end

    execute 'alter table openbill_accounts alter created_at set default now()'
    execute 'alter table openbill_accounts alter updated_at set default now()'

    add_index :openbill_accounts, :user_key, :unique => true

    create_table :openbill_transactions do |t|
      t.integer  :from_account_id, :null => false
      t.integer  :to_account_id, :null => false
      t.decimal  :amount, :null => false, :default => 0, :precision => 12, :scale => 2
      t.text     :details, :null => false
      t.timestamp :created_at, :null => false
    end

    execute 'alter table openbill_transactions alter created_at set default now()'

    add_index :openbill_transactions, [:from_account_id, :to_account_id], :name => :ot_ft
    add_index :openbill_transactions, [:to_account_id, :from_account_id], :name => :ot_tf
  end
end
