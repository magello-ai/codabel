require 'spec_helper'

describe Codabel::Type::BalanceSign do
  subject do
    Codabel::Type::BalanceSign.new
  end

  it 'generates a 0 for positive amounts' do
    expect(subject.to_coda(0, 1)).to eql('0')
    expect(subject.to_coda(123, 1)).to eql('0')
  end

  it 'generates a 1 for negative amounts' do
    expect(subject.to_coda(-123, 1)).to eql('1')
  end

  it 'pads with 0' do
    expect(subject.to_coda(-123, 2)).to eql('01')
  end
end
