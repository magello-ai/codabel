module Codabel
  class Column
    def initialize(range, name, type, options)
      @range = range
      @name = name
      @type = type
      @options = options
    end
    attr_reader :range
    attr_reader :name
    attr_reader :type
    attr_reader :options

    def length
      range.size
    end

    def to_coda(record)
      value = record.data.fetch(name, options[:default])
      type.to_coda(value, length)
    end
  end
end
