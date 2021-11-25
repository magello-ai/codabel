# Codabel - Generate CODA files with ease

This gem allows generating CODA files (belgian financial format) from structured
data. We currently support version 2.6 of the Febelfin specification:

- https://www.febelfin.be/sites/default/files/2019-04/standard-coda-2.6-en.pdf

## Features

* Support for CODA records 0, 1, 2.1, 2.2, 2.3, 3.1, 3.2, 3.3, 8 and 9.
* Easy CODA generation from a high-level data model
* Access for fine-grained details through detailed record data
* Automatical split of mouvements to records 2.x and 3.x
* Automatic generation of next and link codes
* Automatic generation of trailer record details
* Basic check of balances and trailer record (debit, credit, record count)

### Limitations

* No support for free information records (4)
* No high-level data model for transaction codes (record 2.1)
* No high-level data model for R-transaction and reason (record 2.2)
* No high-level data model for purpose and category purpose (record 2.2)

## Example

```ruby
today = Date.parse('2021-11-18')
file = Codabel::File.new
file << Codabel::Record.header(
  creation_date: today
)
file << Codabel::Record.old_balance(
  balance_date: today,
  balance: 1765
)
file << Codabel::Record.movement(
  amount: 107980, # amounts are always in cents
  entry_date: today,
  value_date: today,
  communication: {
    structured: '121204102125'
  }
)
file << Codabel::Record.movement(
  amount: -6789,
  entry_date: today,
  value_date: today,
  communication: {
    unstructured: 'Buying flowers'
  }
)
file << Codabel::Record.new_balance(
  balance_date: today,
  balance: 1765 + 107980 - 6789
)
file << Codabel::Record.trailer
puts file.to_coda
```

## Licence

Codabel is distributed by Flexio (https://flexio.app) under a MIT licence
(see LICENCE.md)

## Contribute

* Fork the library
* Add the features that you want together with the unit and integration tests
* Please double check that you don't introduce a broken API without reason
* Open a pull request and relax!
* Don't hesitate to ping the maintainer by email (bernard, you know, at flexio.app)
