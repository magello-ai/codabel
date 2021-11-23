require 'spec_helper'

describe Codabel::Record::Header do
  subject {
    Codabel::Record::Header.for(data)
  }

  context 'with empty data' do
    let(:data) {
      { creation_date: Date.parse('2021-11-18') }
    }

    it 'generates a default record' do
      got = subject.to_coda
      expected = <<CODA.strip
0000018112100005                                                                   00000                                       2
CODA
      expect(got).to eql(expected)
    end
  end

  context 'with full data' do
    let(:data) {
      {
        bank_identifier: '123',
        duplicate: true,
        file_reference: 'foobarbaz',
        addressee_name: 'Bernard Lambeau',
        bank: { bic: 'GKCCBEBB' },
        creation_date: Date.parse('2021-11-18'),
        holder_identifier: '558926866',
        transaction_reference: 'transaction ref',
        related_reference: 'related ref'
      }
    }

    it 'generates the expected record' do
      got = subject.to_coda
      expected = <<CODA.strip
0000018112112305D       foobarbaz Bernard Lambeau           GKCCBEBB   00558926866 00000transaction ref related ref            2
CODA
      expect(got).to eql(expected)
    end
  end
end
