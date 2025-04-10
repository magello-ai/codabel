module Codabel
  class Type
    class Communication < Type
      # 101 is the code for Credit transfer or cash payment with structured format communication
      # See: https://febelfin.be/media/pages/publicaties/2021/gecodeerde-berichtgeving-coda/a19b07a7ad-1694763197/standard-coda-2.6-en.pdf
      DEFAULT_STRUCTURED_CODE = '101'.freeze

      def to_coda(value, length)
        communication = communication_from(value)
        check!(communication.length <= length, "Communication `#{communication}` is too long")

        communication.ljust(length, ' ')
      end

      private

      def communication_from(value)
        case value
        when Hash
          extract_communication_from(value)
        when String
          value.to_s
        else
          check!(false, "Unexpected communication #{value}")
        end
      end

      def extract_communication_from(hash)
        if hash[:structured]
          (hash[:structured_code] || DEFAULT_STRUCTURED_CODE) + hash[:structured].to_s
        elsif hash[:unstructured]
          hash[:unstructured].to_s
        else
          ''
        end
      end
    end
  end
end
