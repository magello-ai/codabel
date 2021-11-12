require 'spec_helper'

describe Codabel::Record::Trailer do
  subject {
    Codabel::Record::Trailer.for(data)
  }

  context 'with empty data' do
    let(:data) {
      {}
    }

    it 'generates a default record' do
      got = subject.to_coda
      expected = <<CODA.strip
9               000002000000000000000000000000000000                                                                           2
CODA
      expect(got).to eql(expected)
    end
  end

  context 'with full data' do
    let(:data) {
      {
        records_count: 10,
        debit: 123.45,
        credit: 678.90,
        file_follows: true
      }
    }

    it 'generates the expected record' do
      got = subject.to_coda
      expected = <<CODA.strip
9               000010000000000012345000000000067890                                                                           1
CODA
      expect(got).to eql(expected)
    end
  end
end
