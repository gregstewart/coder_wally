# CoderWally

[![Build Status](https://circleci.com/gh/gregstewart/coder_wally.svg?style=badge)](https://circleci.com/gh/gregstewart/coder_wally)

[![Gem Version](https://badge.fury.io/rb/coder_wally.svg)](http://badge.fury.io/rb/coder_wally)
[![Coverage Status](https://coveralls.io/repos/gregstewart/coder_wally/badge.svg?branch=master&service=github)](https://coveralls.io/github/gregstewart/coder_wally?branch=master)
[![Code Climate](https://codeclimate.com/github/gregstewart/coder_wally/badges/gpa.svg)](https://codeclimate.com/github/gregstewart/coder_wally)
[![Dependency Status](https://gemnasium.com/gregstewart/coder_wally.svg)](https://gemnasium.com/gregstewart/coder_wally)
[![Inline docs](https://inch-ci.org/github/gregstewart/coder_wally.svg?branch=master)](https://inch-ci.org/github/gregstewart/coder_wally)
[![coder_wally API Documentation](https://www.omniref.com/ruby/gems/coder_wally.png)](https://www.omniref.com/ruby/gems/coder_wally)

A very very simple Gem to fetch user badges from Coder Wall

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'coder_wally'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install coder_wally

## Usage

After installing the Gem, you can for now you can invoke it
(remember to replace <username> with you a valid username) from the command line
using:

    ruby -Ilib bin/coder_wally <username>

In order to get a user's badges, you do this:

    client = CoderWally::Client.new(<username>)
    client.user.badges

In order to get a user's details, you do this:

    client = CoderWally::Client.new(<username>)
    client.user.details

In order to get a user's accounts, you do this:

    client = CoderWally::Client.new(<username>)
    client.user.accounts

In order to get everything (for now user, accounts and badges), you do this:

    client = CoderWally::Client.new(<username>)
    client.user

## Contributing

1. Fork it ( https://github.com/gregstewart/coder_wally/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
