module Codabel
  class Record
    class Movement22 < Record
      COMM_LENGTH = 1 + (63 - 11)
      SHARED = %i[sequence_number detail_number communication next_code link_code].freeze

      column 1..1,     nil,                        Type::N,                default: 2
      column 2..2,     nil,                        Type::N,                default: 2
      column 3..6,     :sequence_number,           Type::N,                default: 1
      column 7..10,    :detail_number,             Type::N,                default: 0
      column 11..63,   :communication,             Type::AN,               default: ''
      column 64..98,   %i[counterparty reference], Type::AN,               default: ''
      column 99..109,  %i[counterparty bank bic],  Type::AN,               default: ''
      column 110..112, nil,                        Type::Blank,            default: ''
      column 113..113, :return_transaction_type,   Type::ReturnTransactionType, default: ''
      column 114..117, :reason_return_code,        Type::AN,               default: nil
      column 118..121, :purpose_category,          Type::AN,               default: ''
      column 122..125, :purpose,                   Type::AN,               default: ''
      column 126..126, :next_code,                 Type::Flag,             default: false
      column 127..127, nil,                        Type::Blank,            default: ''
      column 128..128, :link_code,                 Type::Flag,             default: false
    end
  end
end
