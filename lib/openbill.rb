module OpenBill

end

require 'openbill/repository'
OpenBill::Repository.connect
require 'openbill/account'
require 'openbill/transaction'
