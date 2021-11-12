module Codabel
  class Record
    class Trailer < Record
      FOLLOWING = { when_true: '1', when_false: '2' }.freeze

      column 1..1,     nil,              Type::N,                     default: 9
      column 2..16,    nil,              Type::AN,                    default: ''
      column 17..22,   :records_count,   Type::N,                     default: 2
      column 23..37,   :debit,           Type::Amount,                default: 0
      column 38..52,   :credit,          Type::Amount,                default: 0
      column 53..127,  nil,              Type::AN,                    default: ''
      column 128..128, :file_follows,    Type::Flag.new(**FOLLOWING), default: false
    end
  end
end
