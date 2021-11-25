module Codabel
  class Record
    class Movement32 < Record
      COMM_LENGTH = 1 + (115 - 11)

      column 1..1,     nil,                Type::N,                  default: 3
      column 2..2,     nil,                Type::N,                  default: 2
      column 3..6,     :sequence_number,   Type::N,                  default: 1
      column 7..10,    :detail_number,     Type::N,                  default: 0
      column 11..115,  :communication,     Type::Communication,      default: ''
      column 116..125, nil,                Type::Blank
      column 126..126, :next_code,         Type::Flag,               default: false
      column 127..127, nil,                Type::Blank,              default: ''
      column 128..128, :link_code,         Type::Flag,               default: false
    end
  end
end
