require 'spec_helper'

describe Codabel::Record::Movement do
  let(:movement) {
    Codabel::Record::Movement.for(data)
  }

  let(:data) {
    {}
  }

  it 'builds a Movement instance' do
    expect(movement).to be_a(Codabel::Record::Movement)
  end

  describe 'actual_movements' do
    subject {
      Codabel::Record::Movement.for(data).send(:actual_movements)
    }

    after do
      expect(-> { movement.to_coda }).not_to raise_error
    end

    context 'when only a 21 is needed' do
      let(:data) {
        {
          communication: 'a' * 53
        }
      }

      it 'generates only one 21' do
        expect(subject.size).to eql(1)
        expect(subject.first).to be_a(Codabel::Record::Movement21)
      end
    end

    context 'when only a 21 is needed (explicit unstructured)' do
      let(:data) {
        {
          communication: { unstructured: 'a' * 53 }
        }
      }

      it 'generates only one 21' do
        expect(subject.size).to eql(1)
        expect(subject.first).to be_a(Codabel::Record::Movement21)
      end
    end

    context 'when only a 21 is needed (explicit structured)' do
      let(:data) {
        {
          communication: { structured: '121204102125' }
        }
      }

      it 'generates only one 21' do
        expect(subject.size).to eql(1)
        expect(subject.first).to be_a(Codabel::Record::Movement21)
      end
    end

    context 'when the communication is too long to fit a single 21' do
      let(:data) {
        {
          communication: 'a' * 53 + 'b' * 53
        }
      }

      it 'generates an additional 22' do
        expect(subject.size).to eql(2)
        expect(subject[0]).to be_a(Codabel::Record::Movement21)
        expect(subject[1]).to be_a(Codabel::Record::Movement22)
      end
    end

    context 'when the communication is too long that it requires a 23 movement' do
      let(:data) {
        {
          communication: 'a' * 53 + 'b' * 53 + 'c' * 100
        }
      }

      it 'generates an additional 23' do
        expect(subject.size).to eql(3)
        expect(subject[0]).to be_a(Codabel::Record::Movement21)
        expect(subject[1]).to be_a(Codabel::Record::Movement22)
        expect(subject[2]).to be_a(Codabel::Record::Movement23)
      end
    end

    context 'when there are a structured and unstructured communication' do
      let(:data) {
        {
          communication: {
            structured: '121204102125',
            unstructured: 'a'
          }
        }
      }

      it 'generates a 21 and a 31' do
        expect(subject.size).to eql(2)
        expect(subject[0]).to be_a(Codabel::Record::Movement21)
        expect(subject[1]).to be_a(Codabel::Record::Movement31)
      end
    end

    context 'when there are a structured and long unstructured communication' do
      let(:data) {
        {
          communication: {
            structured: '121204102125',
            unstructured: 'a' * 73 + 'b' * 105 + 'c' * 100
          }
        }
      }

      it 'generates a 21 and a 31, 32 and 33' do
        expect(subject.size).to eql(4)
        expect(subject[0]).to be_a(Codabel::Record::Movement21)
        expect(subject[1]).to be_a(Codabel::Record::Movement31)
        expect(subject[2]).to be_a(Codabel::Record::Movement32)
        expect(subject[3]).to be_a(Codabel::Record::Movement33)
      end
    end

    context 'when there is a counterparty reference' do
      let(:data) {
        {
          counterparty: { reference: 'foobar' }
        }
      }

      it 'generates an additional 22' do
        expect(subject.size).to eql(2)
        expect(subject[0]).to be_a(Codabel::Record::Movement21)
        expect(subject[1]).to be_a(Codabel::Record::Movement22)
      end
    end

    context 'when there is a counterparty name' do
      let(:data) {
        {
          counterparty: { name: 'foobar' }
        }
      }

      it 'generates an additional 23' do
        expect(subject.size).to eql(2)
        expect(subject[0]).to be_a(Codabel::Record::Movement21)
        expect(subject[1]).to be_a(Codabel::Record::Movement23)
      end
    end
  end
end
