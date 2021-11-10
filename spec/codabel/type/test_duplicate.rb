require 'spec_helper'

describe Codabel::Type::Duplicate do
  subject do
    Codabel::Type::Duplicate.new
  end

  it 'generates a D for truthy' do
    expect(subject.to_coda(true, 1)).to eql('D')
    expect(subject.to_coda(1, 1)).to eql('D')
    expect(subject.to_coda('foo', 1)).to eql('D')
  end

  it 'generates a blank for falsy' do
    expect(subject.to_coda(false, 1)).to eql(' ')
    expect(subject.to_coda(nil, 1)).to eql(' ')
  end

  it 'pads the string when length is greater than 1' do
    expect(subject.to_coda(true, 2)).to eql(' D')
    expect(subject.to_coda(false, 2)).to eql('  ')
  end
end
