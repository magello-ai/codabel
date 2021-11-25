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
9               000000000000000000000000000000000000                                                                           2
CODA
      expect(got).to eql(expected)
    end
  end

  context 'with full data' do
    let(:data) {
      {
        records_count: 17,
        debit: 12_345,
        credit: 67_890,
        file_follows: true
      }
    }

    it 'generates the expected record' do
      got = subject.to_coda
      expected = <<CODA.strip
9               000017000000000123450000000000678900                                                                           1
CODA
      expect(got).to eql(expected)
    end
  end
end
