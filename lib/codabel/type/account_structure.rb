module Codabel
  class Type
    class AccountStructure < Type
      CODES = {
        Model::Account::BELGIAN_BBAN => '0',
        Model::Account::FOREIGN_BBAN => '1',
        Model::Account::BELGIAN_IBAN => '2',
        Model::Account::FOREIGN_IBAN => '3'
      }.freeze

      def to_coda(value, length)
        return value.to_s.rjust(length, '0') if %w[1 2 3 4].include?(value.to_s)

        structure = Model::Account.dress(value).structure
        CODES[structure].ljust(length, '0')
      end
    end
  end
end
