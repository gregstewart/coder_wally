require 'minitest/autorun'
require 'coder_wally/api'

describe 'api' do
  describe 'memoize result' do
    before do
      @accept_encoding = 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3'
      @success_fixture = File.dirname(__FILE__) + '/./fixtures/200.json'
      @success_response = open(File.expand_path(@success_fixture)).read

      stub_request(:get, 'https://coderwall.com/me.json')
      .with(headers: { 'Accept' => '*/*',
                       'Accept-Encoding' => @accept_encoding,
                       'User-Agent' => 'Ruby' })
      .to_return(status: 200, body:  @success_response, headers: {})
    end

    it 'calls the send_request method only the first time for any given username' do
      api = CoderWally::API.new

      api.fetch('me')
      api.fetch('me')

      api.response.count.must_equal 1

      stub_request(:get, 'https://coderwall.com/foo.json')
      .with(headers: { 'Accept' => '*/*',
                       'Accept-Encoding' => @accept_encoding,
                       'User-Agent' => 'Ruby' })
      .to_return(status: 200, body:  @success_response, headers: {})

      api.fetch('foo')
      api.response.count.must_equal 2
    end


  end
end