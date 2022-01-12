require 'spec_helper'

describe Codabel::Record::Movement23 do
  subject {
    Codabel::Record::Movement23.for(data)
  }

  context 'with empty data' do
    let(:data) {
      { entry_date: Date.parse('2021-11-18') }
    }

    it 'generates a default record' do
      got = subject.to_coda
      expected = <<CODA.strip
2300010000                                  EUR                                                                              0 0
CODA
      expect(got).to eql(expected)
    end
  end

  context 'with typical data' do
    let(:data) {
      {
        sequence_number: 17,
        detail_number: 3,
        counterparty: {
          name: 'Ignite Favor',
          account: {
            number: 'BE68539007547034',
            currency: 'EUR'
          }
        },
        communication: 'Hello world'
      }
    }

    it 'generates a default record' do
      got = subject.to_coda
      expected = <<CODA.strip
2300170003BE68539007547034                  EURIgnite Favor                       Hello world                                0 0
CODA
      expect(got).to eql(expected)
    end
  end

  context 'with an invalid account currency' do
    let(:data) {
      {
        sequence_number: 17,
        detail_number: 3,
        counterparty: {
          name: 'Ignite Favor',
          account: {
            number: 'BE68539007547034',
            currency: '-12.30'
          }
        },
        communication: 'Hello world'
      }
    }

    it 'raises an understandable error' do
      expect(lambda {
        Codabel::Record::Movement23.for(data).to_coda
      }).to raise_error(Codabel::ValidationError)
    end
  end
end
