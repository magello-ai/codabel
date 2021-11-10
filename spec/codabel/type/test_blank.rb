require 'spec_helper'

describe Codabel::Type::Blank do
  subject do
    Codabel::Type::Blank.new
  end

  it 'generates blanks' do
    expect(subject.to_coda(nil, 6)).to eql('      ')
  end

  it 'ignores the value' do
    expect(subject.to_coda('foo', 6)).to eql('      ')
  end
end
