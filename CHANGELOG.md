### next

* Moved the development dependencies from the gemspec to the Gemfile (#19)
* Introduce `after_response` callback (#22)

### 1.1.0

* Added support for Gem release automation

### 1.0.0

* Bundler >= 2.3 is from now on required as minimal version (#18)
* Dropped support for Ruby < 2.5 (#18)
* Dropped support for Rails < 5.2 (#18)
* Updated all development/runtime gems to their latest
  Ruby 2.5 compatible version (#18)

### 0.4.1

* Added `InvoiceComment` models (#17)

### 0.3.0

* Improve error handling (breaking change, as we are now raising
  `Billomat::GatewayError`s rather than just the client's
  `RestClient::Exception`) (#15)
* Added bang variants to API methods
  (`Billomat::Models::Base#{save!,create!,update!,delete!}`) (#16)
* Added `CreditNote` and `CreditNoteItem` models (#14)
* Moved to GitHub Actions
* Migrated to our own coverage reporting

### 0.2.0

* Add codeclimate test runner
* Update codeclimate reporter id
* Switched to SVG project teasers
* Updated Travis CI and Code Climate configs (#11)
* Changed travis-ci.org to travis-ci.com links
* Adds templates and tags to models (#13)

### 0.1.6

* Support registered apps
* Added `app_id` and `app_secret` to configuration (#9)

### 0.1.5

* Added contact support

### 0.1.4

* Made timeout configurable

### 0.1.3

* Added `#as_json` to base model

### 0.1.2

* Small fixes and code coverage

### 0.1.1

* Improved documentation and README

### 0.1.0

* Initial release
