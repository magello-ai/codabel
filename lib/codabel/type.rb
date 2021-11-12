module Codabel
  class Type
    def to_coda(_value, _length)
      raise NotImplementedError, "#{self.class}#to_coda"
    end

    def check!(assertion, message)
      return if assertion

      raise TypeError, message + " for type #{self.class}"
    end
  end
end
require_relative 'type/account_structure'
require_relative 'type/account_and_currency'
require_relative 'type/account_description'
require_relative 'type/an'
require_relative 'type/amount'
require_relative 'type/amount_sign'
require_relative 'type/blank'
require_relative 'type/date'
require_relative 'type/duplicate'
require_relative 'type/flag'
require_relative 'type/n'
require_relative 'type/holder'
