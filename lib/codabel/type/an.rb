module Codabel
  class Type
    class AN < Type
      def to_coda(value, length)
        str = value.to_s
        check!(str.length <= length, "Value `#{value}` is too long")

        str.ljust(length, ' ')
      end
    end
  end
end
