module Codabel
  class Model
    class Account < Model
      BELGIAN_BBAN = :belgian_bban
      FOREIGN_BBAN = :foreign_bban
      BELGIAN_IBAN = :belgian_iban
      FOREIGN_IBAN = :foreign_iban

      def initialize(attributes = {})
        super(check!(attributes))
      end

      def check!(attributes)
        attributes = attributes.dup

        if (c = attributes[:currency])
          c = attributes[:currency] = c.strip
          raise ValidationError, "Wrong currency #{c}" unless c =~ /^[A-Z]{3}$/
        end

        attributes
      end

      def self.dress(value)
        case value
        when Account then value
        when String  then new(number: value)
        when Hash    then new(value)
        else
          raise ArgumentError, "Unable to dress `#{value}` as an Account"
        end
      end

      def currency
        @currency ||= (super || 'EUR').to_s.gsub(/\s/, '')
      end

      def number
        @number ||= super.to_s.gsub(/\s/, '')
      end

      def structure
        @structure ||= super || infer_structure
      end

      def infer_structure
        case number.to_s.strip
        when /^BE\d{14}$/
          BELGIAN_IBAN
        when /^[A-Z]{2}\d{2}\d{12,30}/
          FOREIGN_IBAN
        when /^\d{12}$/
          BELGIAN_BBAN
        else
          FOREIGN_BBAN
        end
      end
    end
  end
end
