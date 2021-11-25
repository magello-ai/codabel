module Codabel
  class Record
    class Movement31 < Record
      COMM_LENGTH = 1 + (113 - 41)

      column 1..1,     nil,                Type::N,                  default: 3
      column 2..2,     nil,                Type::N,                  default: 1
      column 3..6,     :sequence_number,   Type::N,                  default: 1
      column 7..10,    :detail_number,     Type::N,                  default: 0
      column 11..31,   :bank_reference,    Type::AN,                 default: ''
      column 32..39,   :transaction_code,  Type::N,                  default: 0
      column 40..40,   :communication,     Type::CommunicationType,  default: ''
      column 41..113,  :communication,     Type::Communication,      default: ''
      column 114..125, nil,                Type::Blank
      column 126..126, :next_code,         Type::Flag,               default: false
      column 127..127, nil,                Type::Blank,              default: ''
      column 128..128, :link_code,         Type::Flag,               default: false
    end
  end
end
