require 'spec_helper'

describe Codabel::Type::N do
  subject do
    Codabel::Type::N.new
  end

  it 'padds the number with zeros' do
    expect(subject.to_coda(12, 6)).to eql('000012')
  end

  it 'supports converting the number first' do
    expect(subject.to_coda('12ab', 6)).to eql('000012')
  end

  it 'raises an ArgumentError if too long' do
    expect do
      subject.to_coda(12_345_678, 6)
    end.to raise_error(Codabel::TypeError)
  end
end
