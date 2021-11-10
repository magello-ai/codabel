module Codabel
  class Type
    class Blank < Type
      def to_coda(_value, length)
        ' ' * length
      end
    end
  end
end
