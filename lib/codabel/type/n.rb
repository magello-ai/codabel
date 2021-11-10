module Codabel
  class Type
    class N < Type
      def to_coda(value, length)
        str = value.to_i.to_s
        check!(str.length <= length, "Value `#{value}` is too long")

        str.rjust(length, '0')
      end
    end
  end
end
