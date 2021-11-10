module Codabel
  class Type
    class Holder < Type
      def to_coda(value, length)
        str = value.to_s
        return str.ljust(length, ' ') if str.empty?

        str = $1 if str =~ /^BE0(.*)/
        check!(str.length <= length, "Value `#{value}` is too long")

        str.rjust(length, '0')
      end
    end
  end
end
