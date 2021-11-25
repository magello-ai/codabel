require 'spec_helper'

describe Codabel::Type::Communication do
  subject do
    Codabel::Type::Communication.new
  end

  it 'recognizes an unstructured: String' do
    expect(subject.to_coda({ unstructured: 'hello' }, 6)).to eql('hello ')
  end

  it 'recognizes a String' do
    expect(subject.to_coda('hello', 6)).to eql('hello ')
  end

  it 'recognizes an structured: String' do
    expect(subject.to_coda({ structured: '121204102125' }, 17)).to eql('110121204102125  ')
  end
end
