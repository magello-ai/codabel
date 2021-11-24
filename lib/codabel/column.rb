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
      value = record.data.dig(*path) unless path.empty?
      value = options[:default] if value.nil?
      type.to_coda(value, length)
    end

    def path_starts_with?(prefix)
      prefix = Array(prefix)
      @path[0...prefix.size] == prefix
    end

    def specifics?(data)
      return false if path.empty?

      !!data.dig(*path)
    end
  end
end
