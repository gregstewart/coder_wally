require 'minitest/autorun'
require 'coder_wally'

describe 'Coder Wally' do
  before do
    @accept_encoding = 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3'
    @success_fixture = File.dirname(__FILE__) + '/./fixtures/200.json'
  end

  describe 'user badges' do
    describe 'valid user' do
      before do
        success_response = open(File.expand_path(@success_fixture)).read
        stub_request(:get, 'https://coderwall.com/me.json')
          .with(headers: { 'Accept' => '*/*',
                           'Accept-Encoding' => @accept_encoding,
                           'User-Agent' => 'Ruby' })
          .to_return(status: 200, body:  success_response, headers: {})
        @client = CoderWally::Client.new('me')
      end

      it 'returns a hash of badges' do
        badges = @client.get_badges_for('me')

        badges.count.must_equal 11
        badges.first.name.must_equal 'Lab'
        badges.first.badge.must_equal 'https://d3levm2kxut31z.cloudfront.net/assets/badges/labrador-1eb0fc532826e5a7c5487855f9880627.png'
        badges.first.description.must_equal 'Have at least one original repo where C# is the dominant language'
        badges.first.created.must_equal '2014-07-10T23:36:47Z'
      end
    end

    describe 'invalid user' do
      it 'throws an exception when no user is passed in' do
        err = -> { CoderWally::Client.new() }.must_raise ArgumentError
        err.message.must_match(/wrong number/)
      end

      it 'throws an exception when empty string is passed in' do
        err = -> { CoderWally::Client.new('') }.must_raise ArgumentError
        err.message.must_match(/Please provide a username/)
      end

      describe 'not found' do
        before do
          not_found_fixture = File.dirname(__FILE__) + '/./fixtures/404.json'
          not_found_response = open(File.expand_path(not_found_fixture)).read
          stub_request(:get, 'https://coderwall.com/me.json')
            .with(headers: { 'Accept' => '*/*',
                             'Accept-Encoding' => @accept_encoding,
                             'User-Agent' => 'Ruby' })
            .to_return(status: 404, body:  not_found_response, headers: {})
        end

        it 'throws a UserNotFoundError when the user is not found' do
          err = -> { CoderWally::Client.new('me') }.must_raise UserNotFoundError
          err.message.must_match(/User not found/)
        end
      end
    end

    describe 'service throws an error' do
      before do
        empty_fixture = File.dirname(__FILE__) + '/./fixtures/empty.json'
        server_error = open(File.expand_path(empty_fixture)).read
        stub_request(:get, 'https://coderwall.com/me.json')
          .with(headers: { 'Accept' => '*/*',
                           'Accept-Encoding' => @accept_encoding,
                           'User-Agent' => 'Ruby' })
          .to_return(status: 500, body:  server_error, headers: {})
      end

      it 'throws a ServerError when the server response is 500' do
        err = -> { CoderWally::Client.new('me') }.must_raise ServerError
        err.message.must_match(/Server error/)
      end
    end

    describe 'bad data' do
      before do
        bad_json_fixture = File.dirname(__FILE__) + '/./fixtures/bad.json'
        bad_data = open(File.expand_path(bad_json_fixture)).read
        stub_request(:get, 'https://coderwall.com/me.json')
          .with(headers: { 'Accept' => '*/*',
                           'Accept-Encoding' => @accept_encoding,
                           'User-Agent' => 'Ruby' })
          .to_return(status: 200, body:  bad_data, headers: {})
      end

      it 'throws a InvalidJson exception when bad JSON is returned' do
        err = -> { CoderWally::Client.new('me') }.must_raise InvalidJson
        err.message.must_match(/invalid json/)
      end
    end
  end

  describe 'user details' do
    before do
      success_response = open(File.expand_path(@success_fixture)).read
      stub_request(:get, 'https://coderwall.com/me.json')
        .with(headers: { 'Accept' => '*/*',
                         'Accept-Encoding' => @accept_encoding,
                         'User-Agent' => 'Ruby' })
        .to_return(status: 200, body:  success_response, headers: {})
      @client = CoderWally::Client.new('me')
    end

    it 'returns a user' do
      user = @client.get_details_for('me')
      user[:name].must_equal 'Greg Stewart'
      user[:username].must_equal 'gregstewart'
      user[:location].must_equal 'London, UK'
      user[:team].must_be_nil
      user[:endorsements].must_be_kind_of Integer
    end
  end

  describe 'everything' do
    before do
      success_response = open(File.expand_path(@success_fixture)).read
      stub_request(:get, 'https://coderwall.com/me.json')
        .with(headers: { 'Accept' => '*/*',
                         'Accept-Encoding' => @accept_encoding,
                         'User-Agent' => 'Ruby' })
        .to_return(status: 200, body:  success_response, headers: {})

      @client = CoderWally::Client.new('me')
      @coder_wall = @client.get_everything_for('me')
    end

    it 'returns a coderwall object' do
      @coder_wall.must_be_instance_of CoderWally::CoderWall
    end

    it 'has a user object' do
      @coder_wall.user.must_be_instance_of CoderWally::User
    end

    it 'has a collection of badges' do
      @coder_wall.badges.count.must_equal 11
      @coder_wall.badges.first.must_be_instance_of CoderWally::Badge
    end

    it 'has an accounts property' do
      @coder_wall.accounts.must_be_instance_of CoderWally::Account
    end
  end

  describe 'client' do
    before do
      success_response = open(File.expand_path(@success_fixture)).read
      stub_request(:get, 'https://coderwall.com/me.json')
          .with(headers: { 'Accept' => '*/*',
                           'Accept-Encoding' => @accept_encoding,
                           'User-Agent' => 'Ruby' })
          .to_return(status: 200, body:  success_response, headers: {})

      @client = CoderWally::Client.new('me')
    end

    it 'exposes a user object' do
      @client.user.must_be_instance_of CoderWally::User
    end

    describe 'user' do
      it 'has a badges collection' do
        @client.user.badges.count.must_equal 11
        @client.user.badges.first.must_be_instance_of CoderWally::Badge
      end

      it 'has an accounts property' do
        @client.user.accounts.must_be_instance_of CoderWally::Account
      end

      it 'returns a users details' do
        details = @client.user.details

        details[:name].must_equal 'Greg Stewart'
        details[:username].must_equal 'gregstewart'
        details[:location].must_equal 'London, UK'
        details[:team].must_be_nil
        details[:endorsements].must_be_kind_of Integer
      end
    end
  end
end
