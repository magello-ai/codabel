module Codabel
  class File
    def initialize(records = [])
      @records = records
    end
    attr_reader :records

    def <<(record)
      @records << record
    end

    def to_coda
      with_actual_records.auto_enrich._to_coda
    end

    protected

    def with_actual_records
      File.new(@records.map { |record| record.actual_records(self) }.flatten)
    end

    def auto_enrich
      File.new(@records.map { |record| record.auto_enrich(self) }.flatten)
    end

    def _to_coda
      @records.each_with_object('') do |record, memo|
        memo << record.to_coda << "\n"
      end
    end
  end
end
