module Codabel
  class File
    def initialize(records = [])
      @records = records
    end
    attr_reader :records

    def <<(record)
      @records << record
    end

    def find_records(type)
      @records.filter { |record| record.is_a?(type) }
    end

    def find_record(type)
      find_records(type).first
    end

    def validate!
      with_actual_records._validate!
    end

    def to_coda
      with_actual_records.auto_enrich._validate!._to_coda
    end

    protected

    def with_actual_records
      File.new(@records.map { |record| record.actual_records(self) }.flatten)
    end

    def auto_enrich
      File.new(@records.map { |record| record.auto_enrich(self) }.flatten)
    end

    def _validate!
      @records.each { |record| record.validate!(self) }
      self
    end

    def _to_coda
      @records.each_with_object('') do |record, memo|
        memo << record.to_coda << "\n"
      end
    end
  end
end
