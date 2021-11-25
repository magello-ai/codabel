module Codabel
  class Type
    class CommunicationType < Type
      def to_coda(value, length)
        type = type_from(value)
        code = to_code(type)
        code.to_s.rjust(length, '0')
      end

      private

      def type_from(communication)
        case communication
        when Hash
          if communication[:structured]
            :structured
          else
            :unstructured
          end
        when Symbol
          communication
        when String, NilClass
          :unstructured
        else
          check!(false, "Unexpected communication #{communication.inspect}")
        end
      end

      def to_code(type)
        case type
        when 0, 1
          type
        when :unstructured
          0
        when :structured
          1
        else
          check!(false, "Unexpected communication type #{type.inspect}")
        end
      end
    end
  end
end
