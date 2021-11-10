require 'spec_helper'

describe Codabel::Type::AN do
  subject do
    Codabel::Type::AN.new
  end

  it 'left padds the number with blanks' do
    expect(subject.to_coda('foo', 6)).to eql('foo   ')
  end

  it 'raises an ArgumentError if too long' do
    expect do
      subject.to_coda('foobarbaz', 6)
    end.to raise_error(Codabel::TypeError)
  end
end
