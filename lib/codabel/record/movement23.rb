module Codabel
  class Record
    class Movement23 < Record
      COMM_LENGTH = 1 + (125 - 83)
      SHARED = %i[sequence_number detail_number communication link_code].freeze

      column 1..1,     nil,                       Type::N,                  default: 2
      column 2..2,     nil,                       Type::N,                  default: 3
      column 3..6,     :sequence_number,          Type::N,                  default: 1
      column 7..10,    :detail_number,            Type::N,                  default: 0
      column 11..47,   %i[counterparty account],  Type::AccountAndCurrency, default: ''
      column 48..82,   %i[counterparty name],     Type::AN,                 default: ''
      column 83..125,  :communication,            Type::AN,                 default: ''
      column 126..126, nil,                       Type::N,                  default: 0
      column 127..127, nil,                       Type::Blank,              default: ''
      column 128..128, :link_code,                Type::Flag,               default: false
    end
  end
end
