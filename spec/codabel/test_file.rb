require 'spec_helper'

describe Codabel::File do
  it 'allows creating a file easily' do
    file = Codabel::File.new
    file << Codabel::Record.header(creation_date: Date.parse('2021-11-18'))
    file << Codabel::Record.old_balance(balance_date: Date.parse('2021-11-18'))
    # file << Codabel::Record.movement
    # file << Codabel::Record.new_balance
    file << Codabel::Record.trailer
    got = file.to_coda
    expected = <<CODA
0000018112100005                                                                   00000                                       2
12000                                  EUR0000000000000000181121                                                             001
9               000002000000000000000000000000000000                                                                           2
CODA
    expect(got).to eql(expected)
  end
end
