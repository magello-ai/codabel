module Codabel
  class Type
    class AccountAndCurrency < Type
      def to_coda(value, length)
        check!(length == 37, "Expected length to be 37, got #{length}")
        account = Model::Account.dress(value)

        case account.structure
        when Model::Account::BELGIAN_BBAN
          str = account.number.ljust(12, ' ')   # 12 N Belgian account number
          str << ' ' * 1                        #  1 AN blank
          str << account.currency.ljust(3, ' ') #  3 AN ISO currency code or blank
          str << '0'                            #  1 N qualification code or blank
          str << 'BE'                           #  2 AN ISO country code or blank
          str << ' ' * 3                        #  3 AN blank spaces
          str << ' ' * 15                       #  15 AN extension zone or blank
        when Model::Account::FOREIGN_BBAN
          str = account.number.ljust(34, ' ')   # 34 AN foreign account number
          str << account.currency.ljust(3, ' ') #  3 AN ISO currency code of the account
        when Model::Account::BELGIAN_IBAN
          str = account.number.ljust(31, ' ')   # 31 AN IBAN (Belgian number)
          str << ' ' * 3                        # 3 AN extension zone or blank
          str << account.currency.ljust(3, ' ') # 3 AN ISO currency code of the account
        when Model::Account::FOREIGN_IBAN
          str = account.number.ljust(34, ' ')   # 34 AN foreign account number
          str << account.currency.ljust(3, ' ') #  3 AN ISO currency code of the account
        end
      end
    end
  end
end
