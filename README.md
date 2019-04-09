![Billomat](doc/assets/project.svg)

[![Build Status](https://travis-ci.org/hausgold/billomat.svg?branch=master)](https://travis-ci.org/hausgold/billomat)
[![Gem Version](https://badge.fury.io/rb/billomat.svg)](https://badge.fury.io/rb/billomat)
[![Maintainability](https://api.codeclimate.com/v1/badges/21ac719680afa0a102c0/maintainability)](https://codeclimate.com/repos/5cac8ab2feb8e979a4008130/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/21ac719680afa0a102c0/test_coverage)](https://codeclimate.com/repos/5cac8ab2feb8e979a4008130/test_coverage)
[![API docs](https://img.shields.io/badge/docs-API-blue.svg)](https://www.rubydoc.info/gems/billomat)

This gem provides a Ruby API for [billomat.com](https://billomat.com) - an
online accounting service.

- [Installation](#installation)
- [Usage](#usage)
  - [Configuration](#configuration)
  - [Basic usage](#basic-usage)
- [Development](#development)
- [Contributing](#contributing)

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

The billomat gem can be easily configured.
If you're using Rails you might want to put this in your `application.rb`
or inside an initializer.

```ruby
Billomat.configure do |config|
  # Subdomain, e.g. example.billomat.net
  config.subdomain = 'example'
  # API key
  config.api_key   = '4aefdc...'
  # timeout in seconds
  config.timeout   = 5

  # You can also configure a registerd app to increase your
  # API call limit as described here:
  # https://www.billomat.com/en/api/basics/rate-limiting/
  config.app_id = '12345'
  config.app_secret = 'c3df...'
end
```

### Basic usage

Currently there is basic support for the models:
* `Invoice`
* `Client`
* `InvoicePayment`
* `InvoiceItem`
* `Contact`

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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/hausgold/billomat.
