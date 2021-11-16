require 'spec_helper'

describe Codabel::Type::ReturnTransactionType do
  subject do
    Codabel::Type::ReturnTransactionType.new
  end

  it 'generates blanks on nil' do
    expect(subject.to_coda(nil, 6)).to eql('      ')
  end

  it 'recognizes symbols' do
    expect(subject.to_coda(:reject, 1)).to eql('1')
    expect(subject.to_coda(:return, 1)).to eql('2')
    expect(subject.to_coda(:refund, 1)).to eql('3')
    expect(subject.to_coda(:reversal, 1)).to eql('4')
    expect(subject.to_coda(:cancellation, 1)).to eql('5')
  end

  it 'recognizes integers' do
    expect(subject.to_coda(1, 6)).to eql('1     ')
  end

  it 'raises on wrong input' do
    expect { subject.to_coda(17, 6) }.to raise_error(Codabel::TypeError)
  end

  it 'recognizes integers as strings' do
    expect(subject.to_coda('1', 6)).to eql('1     ')
  end

  it 'raises on wrong input' do
    expect { subject.to_coda(17, 6) }.to raise_error(Codabel::TypeError)
    expect { subject.to_coda('17', 6) }.to raise_error(Codabel::TypeError)
    expect { subject.to_coda('foobar', 6) }.to raise_error(Codabel::TypeError)
  end
end
