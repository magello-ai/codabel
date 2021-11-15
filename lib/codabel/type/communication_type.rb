module Codabel
  class Type
    class CommunicationType < Type
      def to_coda(value, length)
        value = case value
                when Integer
                  value
                when :none, :unstructured
                  0
                when :structured
                  1
                else
                  check!(false, "Unexpected value #{value.inspect}")
                end
        value.to_s.rjust(length, '0')
      end
    end
  end
end
