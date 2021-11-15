require 'spec_helper'

describe Codabel::Type::Amount do
  subject do
    Codabel::Type::Amount.new
  end

  it 'works with integers' do
    expect(subject.to_coda(0, 15)).to eql('000000000000000')
    expect(subject.to_coda(123, 15)).to eql('000000000012300')
  end

  it 'works with floats' do
    expect(subject.to_coda(123.7618, 15)).to eql('000000000012376')
  end

  it 'removes the sign' do
    expect(subject.to_coda(-123.76, 15)).to eql('000000000012376')
  end
end
