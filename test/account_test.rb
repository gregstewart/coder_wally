require 'minitest/autorun'
require 'coder_wally/account'

describe 'Account' do
  it 'creates an account object with dynamic attributes' do
    json_parsed = { 'github' => 'gregstewart', 'twitter' => '_greg_stewart_' }

    account = CoderWally::Account.new(json_parsed)

    account.github.must_equal 'gregstewart'
    account.twitter.must_equal '_greg_stewart_'
  end
end
