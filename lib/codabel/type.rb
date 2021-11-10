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
require_relative 'type/an'
require_relative 'type/blank'
require_relative 'type/date'
require_relative 'type/duplicate'
require_relative 'type/n'
require_relative 'type/holder'
