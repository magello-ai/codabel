require 'spec_helper'

describe Codabel::Type::AccountStructure do
  subject do
    Codabel::Type::AccountStructure.new
  end

  it 'recognizes an explicit structure' do
    expect(subject.to_coda({ structure: :belgian_bban }, 1)).to eql('0')
    expect(subject.to_coda({ structure: :foreign_bban }, 1)).to eql('1')
    expect(subject.to_coda({ structure: :belgian_iban }, 1)).to eql('2')
    expect(subject.to_coda({ structure: :foreign_iban }, 1)).to eql('3')
  end

  it 'recognizes a belgian account number' do
    expect(subject.to_coda({ number: '539007547034' }, 1)).to eql('0')
    expect(subject.to_coda('539007547034', 1)).to eql('0')
  end

  it 'recognizes a belgian IBAN' do
    expect(subject.to_coda({ number: 'BE68539007547034' }, 1)).to eql('2')
    expect(subject.to_coda('BE68539007547034', 1)).to eql('2')
  end

  it 'recognizes a european IBAN' do
    expect(subject.to_coda({ number: 'FR7630001007941234567890185' }, 1)).to eql('3')
    expect(subject.to_coda('FR7630001007941234567890185', 1)).to eql('3')
  end

  it 'considers everything else as a international account' do
    expect(subject.to_coda({ number: '12345' }, 1)).to eql('1')
    expect(subject.to_coda('12345', 1)).to eql('1')
  end
end
