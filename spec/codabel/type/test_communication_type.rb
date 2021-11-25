require 'spec_helper'

describe Codabel::Type::CommunicationType do
  subject do
    Codabel::Type::CommunicationType.new
  end

  it 'recognizes :unstructured' do
    expect(subject.to_coda({ unstructured: '' }, 6)).to eql('000000')
  end

  it 'recognizes :structured' do
    expect(subject.to_coda({ structured: '' }, 6)).to eql('000001')
  end

  it 'fallbacks to :unstructured if communication is a string' do
    expect(subject.to_coda('communication', 6)).to eql('000000')
  end

  it 'fallbacks to :none if communication is missing' do
    expect(subject.to_coda(nil, 6)).to eql('000000')
  end
end
