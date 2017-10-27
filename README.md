# Billomat
[![Build Status](https://travis-ci.org/hausgold/billomat.svg?branch=master)](https://travis-ci.org/hausgold/billomat)
[![Gem Version](https://badge.fury.io/rb/billomat.svg)](https://badge.fury.io/rb/billomat)
[![Maintainability](https://api.codeclimate.com/v1/badges/49baf848f42a2e5b95db/maintainability)](https://codeclimate.com/github/hausgold/billomat/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/49baf848f42a2e5b95db/test_coverage)](https://codeclimate.com/github/hausgold/billomat/test_coverage)

This gem provides a Ruby API for [billomat.com](https://billomat.com) - an online accounting service.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'billomat'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install billomat
```

## Usage

### Configuration

The configuration takes two settings: `api_key` and `subdomain`. The latter is e.g. the name of your organization.

```ruby
Billomat.configure do |config|
  config.subdomain = 'your-company'
  config.api_key   = 'a3b148a61cb642389b4f9953f6233f20'
end
```

### Basic usage

Currently there is basic support for the models `Invoice`, `Client`, `InvoicePayment`, `InvoiceItem`

```ruby
Billomat::Models::Invoice.where(invoice_number: 'RE1234')
=> [#<Billomat::Models::Invoice:0x005574b58d6510 ...]

Billomat::Models::Invoice.find('1234')
=> #<Billomat::Models::Invoice:0x005574b58d6510

client = Billomat::Models::Client.find('1234')
client.save
=> true

client.delete
=> true
```

### Documentation

The RubyDoc is available [here](http://www.rubydoc.info/gems/billomat/0.1.2).


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hausgold/billomat.
