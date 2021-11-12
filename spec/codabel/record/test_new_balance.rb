require 'spec_helper'

describe Codabel::Record::NewBalance do
  subject {
    Codabel::Record::NewBalance.for(data)
  }

  context 'with empty data' do
    let(:data) do
      { balance_date: Date.parse('2021-11-18') }
    end

    it 'generates a default record' do
      got = subject.to_coda
      expected = <<CODA.strip
8000                                  EUR0000000000000000181121                                                                0
CODA
      expect(got).to eql(expected)
    end
  end

  context 'with full data' do
    let(:data) do
      {
        balance_date: Date.parse('2021-11-18'),
        sequence_number_paper: 18,
        account: {
          number: 'BE68539007547034',
          currency: 'EUR',
          description: 'Foo bar baz'
        },
        balance: 1234.67
      }
    end

    it 'generates the expected record' do
      got = subject.to_coda
      expected = <<CODA.strip
8018BE68539007547034                  EUR0000000000123467181121                                                                0
CODA
      expect(got).to eql(expected)
    end
  end
end
