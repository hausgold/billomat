![Billomat](doc/assets/project.svg)

[![Continuous Integration](https://github.com/hausgold/billomat/actions/workflows/test.yml/badge.svg?branch=master)](https://github.com/hausgold/billomat/actions/workflows/test.yml)
[![Gem Version](https://badge.fury.io/rb/billomat.svg)](https://badge.fury.io/rb/billomat)
[![Test Coverage](https://automate-api.hausgold.de/v1/coverage_reports/billomat/coverage.svg)](https://knowledge.hausgold.de/coverage)
[![Test Ratio](https://automate-api.hausgold.de/v1/coverage_reports/billomat/ratio.svg)](https://knowledge.hausgold.de/coverage)
[![API docs](https://automate-api.hausgold.de/v1/coverage_reports/billomat/documentation.svg)](https://www.rubydoc.info/gems/billomat)

This gem provides a Ruby API for [billomat.com](https://billomat.com) - an
online accounting service.

- [Installation](#installation)
- [Usage](#usage)
  - [Configuration](#configuration)
  - [Basic usage](#basic-usage)
- [Development](#development)
- [Code of Conduct](#code-of-conduct)
- [Contributing](#contributing)
- [Releasing](#releasing)

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

  config.after_response = lambda do |response|
    # API response callback, e.g. for inspecting the rate limit
    # header via response.headers[:x_rate_limit_remaining]
  end
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

After checking out the repo, run `make install` to install dependencies. Then,
run `make test` to run the tests. You can also run `make shell-irb` for an
interactive prompt that will allow you to experiment.

## Code of Conduct

Everyone interacting in the project codebase, issue tracker, chat
rooms and mailing lists is expected to follow the [code of
conduct](./CODE_OF_CONDUCT.md).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/hausgold/billomat. Make sure that every pull request adds
a bullet point to the [changelog](./CHANGELOG.md) file with a reference to the
actual pull request.

## Releasing

The release process of this Gem is fully automated. You just need to open the
Github Actions [Release
Workflow](https://github.com/hausgold/billomat/actions/workflows/release.yml)
and trigger a new run via the **Run workflow** button. Insert the new version
number (check the [changelog](./CHANGELOG.md) first for the latest release) and
you're done.
