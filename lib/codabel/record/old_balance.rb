module Codabel
  class Record
    class OldBalance < Record
      column 1..1,     nil,                    Type::N,                  default: 1
      column 2..2,     :account,               Type::AccountStructure,   default: 2
      column 3..5,     :sequence_number_paper, Type::N,                  default: 0
      column 6..42,    :account,               Type::AccountAndCurrency, default: ''
      column 43..43,   :balance,               Type::BalanceSign,        default: 0
      column 44..58,   :balance,               Type::Balance,            default: 0
      column 59..64,   :balance_date,          Type::Date,               default: Date.today
      column 65..90,   :holder_name,           Type::AN,                 default: ''
      column 91..125,  :account,               Type::AccountDescription, default: ''
      column 126..128, :sequence_number_daily, Type::N,                  default: 1
    end
  end
end
