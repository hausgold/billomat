### next

* TODO: Replace this bullet point with an actual description of a change.

### 2.6.0 (28 January 2026)

* Dropped Rails 7.1 support ([#43](https://github.com/hausgold/billomat/pull/43))

### 2.5.0 (19 January 2026)

* Added the `ostruct` gem ([#42](https://github.com/hausgold/billomat/pull/42))

### 2.4.0 (7 January 2026)

* Upgraded to Ubuntu 24.04 on Github Actions ([#41](https://github.com/hausgold/billomat/pull/41))
* Migrated to hausgold/actions@v2 ([#40](https://github.com/hausgold/billomat/pull/40))

### 2.3.0 (26 December 2025)

* Added Ruby 4.0 support ([#39](https://github.com/hausgold/billomat/pull/39))
* Dropped Ruby 3.2 and Rails 7.1 support ([#38](https://github.com/hausgold/billomat/pull/38))

### 2.2.0 (19 December 2025)

* Migrated to a shared Rubocop configuration for HAUSGOLD gems ([#37](https://github.com/hausgold/billomat/pull/37))

### 2.1.0 (24 October 2025)

* Dropped Reek ([#35](https://github.com/hausgold/billomat/pull/35))
* Added support for Rails 8.1 ([#36](https://github.com/hausgold/billomat/pull/36))

### 2.0.0 (28 June 2025)

* Corrected some RuboCop glitches ([#33](https://github.com/hausgold/billomat/pull/33))
* Drop Ruby 2 and end of life Rails (<7.1) ([#34](https://github.com/hausgold/billomat/pull/34))

### 1.5.1 (9 May 2025)

* Corrected some RuboCop glitches ([#30](https://github.com/hausgold/billomat/pull/30))
* Upgraded the rubocop dependencies ([#31](https://github.com/hausgold/billomat/pull/31))
* Gracefully deal with non-JSON gateway error bodies ([#32](https://github.com/hausgold/billomat/pull/32))

### 1.5.0 (30 January 2025)

* Added all versions up to Ruby 3.4 to the CI matrix ([#29](https://github.com/hausgold/billomat/pull/29))

### 1.4.1 (17 January 2025)

* Added the logger dependency ([#28](https://github.com/hausgold/billomat/pull/28))

### 1.4.0 (11 January 2025)

* Switched to Zeitwerk as autoloader ([#27](https://github.com/hausgold/billomat/pull/27))

### 1.3.0 (3 January 2025)

* Raised minimum supported Ruby/Rails version to 2.7/6.1 ([#26](https://github.com/hausgold/billomat/pull/26))

### 1.2.5 (15 August 2024)

* Just a retag of 1.2.1

### 1.2.4 (15 August 2024)

* Just a retag of 1.2.1

### 1.2.3 (15 August 2024)

* Just a retag of 1.2.1

### 1.2.2 (9 August 2024)

* Just a retag of 1.2.1

### 1.2.1 (9 August 2024)

* Added API docs building to continuous integration ([#25](https://github.com/hausgold/billomat/pull/25))

### 1.2.0 (8 July 2024)

* Moved the development dependencies from the gemspec to the Gemfile ([#19](https://github.com/hausgold/billomat/pull/19))
* Introduce `after_response` callback ([#22](https://github.com/hausgold/billomat/pull/22))
* Fix response parsing for responses exceeding the page size ([#23](https://github.com/hausgold/billomat/pull/23))
* Dropped support for Ruby <2.7 ([#24](https://github.com/hausgold/billomat/pull/24))

### 1.1.0 (24 February 2023)

* Added support for Gem release automation

### 1.0.0 (18 January 2023)

* Bundler >= 2.3 is from now on required as minimal version ([#18](https://github.com/hausgold/billomat/pull/18))
* Dropped support for Ruby < 2.5 ([#18](https://github.com/hausgold/billomat/pull/18))
* Dropped support for Rails < 5.2 ([#18](https://github.com/hausgold/billomat/pull/18))
* Updated all development/runtime gems to their latest
  Ruby 2.5 compatible version ([#18](https://github.com/hausgold/billomat/pull/18))

### 0.4.1 (27 June 2022)

* Added `InvoiceComment` models ([#17](https://github.com/hausgold/billomat/pull/17))

### 0.3.0 (11 October 2021)

* Improve error handling (breaking change, as we are now raising
  `Billomat::GatewayError`s rather than just the client's
  `RestClient::Exception`) ([#15](https://github.com/hausgold/billomat/pull/15))
* Added bang variants to API methods
  (`Billomat::Models::Base#{save!,create!,update!,delete!}`) ([#16](https://github.com/hausgold/billomat/pull/16))
* Added `CreditNote` and `CreditNoteItem` models ([#14](https://github.com/hausgold/billomat/pull/14))
* Moved to GitHub Actions
* Migrated to our own coverage reporting

### 0.2.0 (12 May 2021)

* Add codeclimate test runner
* Update codeclimate reporter id
* Switched to SVG project teasers
* Updated Travis CI and Code Climate configs ([#11](https://github.com/hausgold/billomat/pull/11))
* Changed travis-ci.org to travis-ci.com links
* Adds templates and tags to models ([#13](https://github.com/hausgold/billomat/pull/13))

### 0.1.6 (16 May 2018)

* Support registered apps
* Added `app_id` and `app_secret` to configuration ([#9](https://github.com/hausgold/billomat/pull/9))

### 0.1.5 (14 November 2017)

* Added contact support

### 0.1.4 (9 November 2017)

* Made timeout configurable

### 0.1.3 (27 October 2017)

* Added `#as_json` to base model

### 0.1.2 (27 October 2017)

* Small fixes and code coverage

### 0.1.1 (19 October 2017)

* Improved documentation and README

### 0.1.0 (5 October 2017)

* Initial release
