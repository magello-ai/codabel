module Codabel
  class Type
    class ReturnTransactionType < Type
      def to_coda(value, length)
        rcode = case value
                when '', NilClass
                  ''
                when 1..5
                  value.to_s
                when :reject
                  '1'
                when :return
                  '2'
                when :refund
                  '3'
                when :reversal
                  '4'
                when :cancellation
                  '5'
                when /^[1-5]$/
                  value
                else
                  check!(false, "Unexpected value `#{value}`")
                end
        rcode.ljust(length, ' ')
      end
    end
  end
end
