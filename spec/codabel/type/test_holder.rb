require 'spec_helper'

describe Codabel::Type::Holder do
  subject do
    Codabel::Type::Holder.new
  end

  it 'lefts padds the number with zeros' do
    expect(subject.to_coda('foo', 6)).to eql('000foo')
  end

  it 'supports a nil' do
    expect(subject.to_coda(nil, 6)).to eql('      ')
  end

  it 'supports a zero-padded identification number' do
    expect(subject.to_coda('0558926866', 10)).to eql('0558926866')
  end

  it 'supports a full identification number' do
    expect(subject.to_coda('BE0558926866', 10)).to eql('0558926866')
  end

  it 'raises an ArgumentError if too long' do
    expect do
      subject.to_coda('foobarbaz', 6)
    end.to raise_error(Codabel::TypeError)
  end
end
