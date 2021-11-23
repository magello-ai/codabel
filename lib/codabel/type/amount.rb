module Codabel
  class Type
    class Amount < Type
      def to_coda(value, length)
        check!(value.is_a?(Integer), 'All amounts must be in cents')

        (value.abs * 10).to_s.rjust(length, '0')
      end
    end
  end
end
