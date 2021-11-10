require 'spec_helper'
describe Codabel::Model::Account do
  describe '.dress' do
    Account = Codabel::Model::Account

    it 'is idempotent' do
      acc = Account.new(number: 'BE68539007547034')
      expect(Account.dress(acc)).to be(acc)
    end

    it 'recognizes account numbers' do
      acc = Account.dress('BE68539007547034')
      expect(acc).to be_a(Account)
      expect(acc.number).to eql('BE68539007547034')
    end

    it 'recognizes Hash' do
      acc = Account.dress(number: 'BE68539007547034')
      expect(acc).to be_a(Account)
      expect(acc.number).to eql('BE68539007547034')
    end
  end

  describe 'number' do
    it 'uses the number that exists' do
      acc = Account.new(number: 'BE68539007547034')
      expect(acc.number).to eql('BE68539007547034')
    end

    it 'strips all spaces' do
      acc = Account.new(number: ' BE 68 53 90 07 54 70 34 ')
      expect(acc.number).to eql('BE68539007547034')
    end
  end

  describe 'currency' do
    it 'uses the currency that exists' do
      acc = Account.new(currency: 'USD')
      expect(acc.currency).to eql('USD')
    end

    it 'strips all spaces' do
      acc = Account.new(currency: ' USD ')
      expect(acc.currency).to eql('USD')
    end

    it 'defaults to EUR' do
      acc = Account.new
      expect(acc.currency).to eql('EUR')
    end
  end

  describe 'structure' do
    it 'uses the structure that exists' do
      acc = Account.new(structure: Account::BELGIAN_IBAN, number: 'BE68539007547034')
      expect(acc.structure).to eql(Account::BELGIAN_IBAN)
    end

    it 'infers the structure otherwise' do
      acc = Account.new(number: '096123456769')
      expect(acc.structure).to eql(Account::BELGIAN_BBAN)

      acc = Account.new(number: 'BE71096123456769')
      expect(acc.structure).to eql(Account::BELGIAN_IBAN)

      acc = Account.new(number: 'FR7630001007941234567890185')
      expect(acc.structure).to eql(Account::FOREIGN_IBAN)

      acc = Account.new(number: '7630001007941234567890185')
      expect(acc.structure).to eql(Account::FOREIGN_BBAN)
    end
  end
end
