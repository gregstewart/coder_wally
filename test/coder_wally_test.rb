require "minitest/autorun"

require "coder_wally"
require "webmock/minitest"

describe "Coder Wally" do
  it "has a default api url" do
    "https://coderwall.com/%s.json".must_equal CoderWally::Url
  end
  
  describe "user badges" do
      describe "valid user" do
        before do
            success_response = open(File.expand_path(File.dirname(__FILE__) + "/./fixtures/200.json")).read
            stub_request(:get, "https://coderwall.com/me.json").
              with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
              to_return(:status => 200, :body => success_response, :headers => {})
        end
        
        it "returns a hash of badges" do
          badges = CoderWally.get_badges_for('me')
          
          badges.count.must_equal 11
          badges.first.name.must_equal "Lab"
          badges.first.badge.must_equal "https://d3levm2kxut31z.cloudfront.net/assets/badges/labrador-1eb0fc532826e5a7c5487855f9880627.png"
          badges.first.description.must_equal "Have at least one original repo where C# is the dominant language"
          badges.first.created.must_equal "2014-07-10T23:36:47Z"
        end
      end
      describe "invalid user" do
        it "throws an exception when no user is passed in" do
          err = ->{ CoderWally.get_badges_for }.must_raise ArgumentError
          err.message.must_match /wrong number/
        end
        
        it "throws an exception when empty string is passed in" do
          err = ->{ CoderWally.get_badges_for "" }.must_raise ArgumentError
          err.message.must_match /Plesae provide a username/
        end
        
        # before do
        #   not_found_response = open(File.expand_path(File.dirname(__FILE__) + "/./fixtures/404.json")).read
        #     stub_request(:get, "https://coderwall.com/me.json").
        #       with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
        #       to_return(:status => 404, :body => not_found_response, :headers => {})
        # end
      end
  end
end