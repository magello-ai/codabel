module Codabel
  class Type
    class BalanceSign < Type
      def to_coda(value, length)
        (value >= 0.0 ? '0' : '1').rjust(length, '0')
      end
    end
  end
end
