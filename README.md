## Overtime App

A Ruby on Rails app based on [Professional Rails Code Along Course](https://www.udemy.com/professional-ruby-on-rails-coding-course/) with various changes and updated packages including Rails 6.

[![Build Status](https://travis-ci.org/mibradev/udemy-professional-ruby-on-rails-coding-course.svg?branch=master)](https://travis-ci.org/mibradev/udemy-professional-ruby-on-rails-coding-course)
[![Maintainability](https://api.codeclimate.com/v1/badges/50c4a4c1f6a6b131868d/maintainability)](https://codeclimate.com/github/mibradev/udemy-professional-ruby-on-rails-coding-course/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/50c4a4c1f6a6b131868d/test_coverage)](https://codeclimate.com/github/mibradev/udemy-professional-ruby-on-rails-coding-course/test_coverage)

### Requirements

* [Ruby](https://www.ruby-lang.org/en/)
* [Bundler](https://bundler.io/)
* [PostgreSQL](https://www.postgresql.org/)
* [Node.js](https://nodejs.org/en/)
* [Yarn](https://yarnpkg.com/en/)
* [Twilio](https://github.com/twilio/twilio-ruby) (for communicating with the Twilio API)
* [New Relic](https://github.com/newrelic/rpm) (for performance management)
* [Rollbar](https://github.com/rollbar/rollbar-gem) (for exception tracking)

### Usage

* Clone the repo
* Install the requirements
* Setup rails credentials
* Run `bundle install`
* Run `yarn install`
* Run `rails db:create`
* Run `rails db:setup`
* Run `rails server`
* Visit http://localhost:3000/

#### Rails Credentials Example

```yaml
default: &default
  user_password: 123456
  twilio:
    account_sid: <your_account_sid>
    auth_token: <your_auth_token>
    number: +15005550006

development:
  <<: *default

test:
  <<: *default

production:
  rollbar_access_token: <your_access_token>
  user_password: <your_password>
  twilio:
    account_sid: <your_account_sid>
    auth_token: <your_auth_token>
    number: <your_number>

newrelic_license_key: <your_license_key>

# Used as the base secret for all MessageVerifiers in Rails, including the one protecting cookies.
secret_key_base: <your_key>
```
