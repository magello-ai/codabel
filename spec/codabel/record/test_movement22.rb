require 'spec_helper'

describe Codabel::Record::Movement22 do
  subject {
    Codabel::Record::Movement22.for(data)
  }

  context 'with empty data' do
    let(:data) {
      { entry_date: Date.parse('2021-11-18') }
    }

    it 'generates a default record' do
      got = subject.to_coda
      expected = <<CODA.strip
2200010000                                                                                                                   0 0
CODA
      expect(got).to eql(expected)
    end
  end

  context 'with typical data' do
    let(:data) {
      {
        sequence_number: 17,
        detail_number: 3,
        communication: 'Hello world',
        customer_reference: 'cus123',
        customer_bank_bic: 'bic456',
        return_transaction_type: :reject,
        reason_return_code: 'ISO',
        purpose_category: 'FOO',
        purpose: 'BAR'
      }
    }

    it 'generates a default record' do
      got = subject.to_coda
      expected = <<CODA.strip
2200170003Hello world                                          cus123                             bic456        1ISO FOO BAR 0 0
CODA
      expect(got).to eql(expected)
    end
  end
end
