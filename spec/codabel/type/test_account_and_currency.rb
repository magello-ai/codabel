require 'spec_helper'

describe Codabel::Type::AccountAndCurrency do
  subject do
    Codabel::Type::AccountAndCurrency.new
  end

  it 'recognizes a belgian BBAN' do
    expect(subject.to_coda('539007547034', 37)).to eql('539007547034 EUR0BE                  ')
  end

  it 'recognizes a foeign BBAN' do
    expect(subject.to_coda('1234', 37)).to eql('1234                              EUR')
  end

  it 'recognizes a belgian IBAN' do
    expect(subject.to_coda('BE68539007547034', 37)).to eql('BE68539007547034                  EUR')
  end

  it 'recognizes a foreign IBAN' do
    expect(subject.to_coda('FR7630001007941234567890185', 37)).to eql('FR7630001007941234567890185       EUR')
  end
end
