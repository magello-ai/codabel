module Codabel
  class Record
    class Movement21 < Record
      COMM_LENGTH = 1 + (115 - 63)

      column 1..1,     nil,                    Type::N,          default: 2
      column 2..2,     nil,                    Type::N,          default: 1
      column 3..6,     :sequence_number,       Type::N,          default: 1
      column 7..10,    :detail_number,         Type::N,          default: 0
      column 11..31,   :bank_reference,        Type::AN,         default: ''
      column 32..32,   :amount,                Type::AmountSign, default: 0
      column 33..47,   :amount,                Type::Amount,     default: 0
      column 48..53,   :value_date,            Type::Date,       default: nil
      column 54..61,   :transaction_code,      Type::N,          default: 0
      column 62..62,   :communication_type,    Type::CommunicationType, default: :none
      column 63..115,  :communication,         Type::AN,         default: ''
      column 116..121, :entry_date,            Type::Date,       default: Date.today
      column 122..124, :sequence_number_paper, Type::N,          default: 0
      column 125..125, :globalisation_code,    Type::N,          default: 0
      column 126..126, :next_code,             Type::Flag,       default: false
      column 127..127, nil,                    Type::Blank,      default: ''
      column 128..128, :link_code,             Type::Flag,       default: false

      def amount
        data[:amount] || 0
      end

      def debit_amount
        data[:amount] <= 0 ? data[:amount] : 0
      end

      def credit_amount
        data[:amount] > 0 ? data[:amount] : 0
      end
    end
  end
end
