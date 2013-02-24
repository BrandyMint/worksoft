Billing
-------

1. Баланс счета не может изменяться напрямую, только через транзакцию.
2. Принцип двойнов записи. Транзакция всегда осуществляется между двумя
счетами. С одного списали, на другой записли.

```
Repository.create_account :user_key => 'user'
Repository.find_account #account_id#

Account#user_key
Account#balance
Account#transactions
Account#make_transaction :from => Account, :to => Account, :amount => 123, :details => 'asd'

AccountState#

Transaction#info
```

SQL triggers TODO
-----------------

1. Запретить возможность изменять и удалять транзакции.
2. Запретить возможность изменять amount аккаунта без транзакции
3. Запретить установку amount аккаунта при создании (только 0)
4. Счета и транзакции нельзя удалять
