module Codabel
  class File
    def initialize
      @records = []
    end

    def <<(record)
      @records << record
    end

    def to_coda
      @records.each_with_object('') do |record, memo|
        memo << record.to_coda << "\n"
      end
    end
  end
end
