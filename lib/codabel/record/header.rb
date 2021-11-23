module Codabel
  class Record
    class Header < Record
      column 1..1,     nil,                    Type::N,         default: 0
      column 2..5,     nil,                    Type::N,         default: 0
      column 6..11,    :creation_date,         Type::Date,      default: Date.today
      column 12..14,   :bank_identifier,       Type::N,         default: 0
      column 15..16,   :application_code,      Type::N,         default: 5
      column 17..17,   :duplicate,             Type::Duplicate, default: false
      column 18..24,   nil,                    Type::Blank
      column 25..34,   :file_reference,        Type::AN,        default: ''
      column 35..60,   :addressee_name,        Type::AN,        default: ''
      column 61..71,   [:bank, :bic],          Type::AN,        default: ''
      column 72..82,   :holder_identifier,     Type::Holder,    default: ''
      column 83..83,   nil,                    Type::Blank
      column 84..88,   :distinct_app_code,     Type::N,         default: 0
      column 89..104,  :transaction_reference, Type::AN,        default: ''
      column 105..120, :related_reference,     Type::AN,        default: ''
      column 121..127, nil,                    Type::Blank
      column 128..128, :version_code,          Type::N,         default: 2
    end
  end
end
