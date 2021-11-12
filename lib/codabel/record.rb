module Codabel
  class Record
    class << self
      def column(range, name, type, options = {})
        type = type.new if type.is_a?(Class)
        add_column Column.new(range, name, type, options)
      end

      def add_column(column)
        columns << column
      end
      private :add_column

      def columns
        @columns ||= []
      end

      def for(data)
        new(data)
      end
    end

    def initialize(data)
      @data = data
    end
    attr_reader :data

    def to_coda
      str = self.class.columns.each_with_object('') do |column, memo|
        memo << column.to_coda(self)
      end
      return str if str.length == 128

      raise Error, "128 characters expected, got #{str.length}\n#{str}"
    end
  end
end
require_relative 'record/header'
require_relative 'record/old_balance'
require_relative 'record/trailer'
