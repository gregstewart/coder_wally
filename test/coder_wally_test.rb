require "minitest/autorun"

require "coder_wally"

describe "Coder Wally" do
  it "has a default api url" do
    "https://coderwall.com/{username}.json".must_equal CoderWally::Url
  end
end