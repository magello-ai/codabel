require 'spec_helper'

describe Codabel::File do
  it 'allows creating a file easily' do
    file = Codabel::File.new
    file << Codabel::Record.header(creation_date: Date.parse('2021-11-18'))
    file << Codabel::Record.old_balance(balance_date: Date.parse('2021-11-18'))
    file << Codabel::Record.movement(
      entry_date: Date.parse('2021-11-18'),
      value_date: Date.parse('2021-11-18'),
      communication: 'a'*53 + 'b'*53 + 'c'*100
    )
    file << Codabel::Record.new_balance(balance_date: Date.parse('2021-11-18'))
    file << Codabel::Record.trailer
    got = file.to_coda
    expected = <<CODA
0000018112100005                                                                   00000                                       2
12000                                  EUR0000000000000000181121                                                             001
2100010000                     0000000000000000181121000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa18112100001 0
2200010000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb                                                              1 0
2300010000                                  EUR                                   ccccccccccccccccccccccccccccccccccccccccccc0 0
8000                                  EUR0000000000000000181121                                                                0
9               000002000000000000000000000000000000                                                                           2
CODA
    expect(got).to eql(expected)
  end
end
