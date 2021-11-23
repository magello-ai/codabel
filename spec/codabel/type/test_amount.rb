require 'spec_helper'

describe Codabel::Type::Amount do
  subject do
    Codabel::Type::Amount.new
  end

  it 'works with integers' do
    expect(subject.to_coda(0, 15)).to eql('000000000000000')
    expect(subject.to_coda(12_300, 15)).to eql('000000000123000')
  end

  it 'raise with floats' do
    expect(-> { subject.to_coda(123.7618, 15) }).to raise_error(Codabel::TypeError)
  end

  it 'removes the sign' do
    expect(subject.to_coda(-12_376, 15)).to eql('000000000123760')
  end
end
