module Codabel
  class Record
    class << self
      def header(data = {})
        Header.new(data)
      end

      def old_balance(data = {})
        OldBalance.new(data)
      end

      def movement(data = {})
        Movement21.new(data)
      end

      def new_balance(data = {})
        NewBalance.new(data)
      end

      def trailer(data = {})
        Trailer.new(data)
      end

      def column(range, name, type, options = {})
        last_index = columns.last&.range&.max || 0
        raise Error, "Wrong column range #{range}, expected #{1+last_index}.." unless range.min == 1+last_index
        raise Error, "Wrong column range #{range}" if range.max > 128

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
require_relative 'record/movement21'
require_relative 'record/movement22'
require_relative 'record/movement23'
require_relative 'record/new_balance'
require_relative 'record/old_balance'
require_relative 'record/trailer'
