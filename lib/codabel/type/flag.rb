module Codabel
  class Type
    class Flag < Type
      def initialize(when_true: '1', when_false: '0')
        @when_true = when_true
        @when_false = when_false
      end

      def to_coda(value, length)
        str = value ? @when_true : @when_false
        str.rjust(length, ' ')
      end
    end
  end
end
