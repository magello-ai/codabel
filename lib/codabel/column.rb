module Codabel
  class Column
    def initialize(range, path, type, options)
      @range = range
      @path = Array(path)
      @type = type
      @options = options
    end
    attr_reader :range
    attr_reader :path
    attr_reader :type
    attr_reader :options

    def length
      range.size
    end

    def to_coda(record)
      value = record.data.dig(*path) if path.size > 0
      value = options[:default] if value.nil?
      type.to_coda(value, length)
    end
  end
end
