module Codabel
  class Type
    class Duplicate < Type
      def to_coda(value, length)
        str = value ? 'D' : ' '
        str.rjust(length, ' ')
      end
    end
  end
end
