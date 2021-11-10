require 'spec_helper'

describe Codabel::Type::Balance do
  subject do
    Codabel::Type::Balance.new
  end

  it 'works with integers' do
    expect(subject.to_coda(0, 15)).to eql('000000000000000')
    expect(subject.to_coda(123, 15)).to eql('000000000012300')
  end

  it 'works with floats' do
    expect(subject.to_coda(123.7618, 15)).to eql('000000000012376')
  end
end
