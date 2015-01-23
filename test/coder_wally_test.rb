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
        end
        
      end
      
  end
end