require 'spec_helper'

describe Codabel::Type::Date do
  subject do
    Codabel::Type::Date.new
  end

  it 'generates the date in DDMMYY format' do
    date = Date.parse('2021-11-06')
    expect(subject.to_coda(date, 6)).to eql('061121')
  end

  it 'supports a string' do
    date = '2021-11-06'
    expect(subject.to_coda(date, 6)).to eql('061121')
  end

  it 'supports a time' do
    date = Time.parse('2021-11-06')
    expect(subject.to_coda(date, 6)).to eql('061121')
  end

  it 'supports nil, and generates zeros' do
    date = nil
    expect(subject.to_coda(date, 6)).to eql('000000')
  end
end
