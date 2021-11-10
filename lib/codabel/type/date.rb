module Codabel
  class Type
    class Date < Type
      def to_coda(value, length)
        check!(length == 6, 'Length of 6 expected')

        value = ::Date.parse(value) if value.is_a?(String)
        value = value.to_date if value.respond_to?(:to_date)
        value.strftime('%d%m%y')
      end
    end
  end
end
