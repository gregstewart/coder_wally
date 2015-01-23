require "coder_wally/version"

require "open-uri"
require "json"

# All code in the gem is namespaced under this module.
module CoderWally
  # The URL of API we'll use.
  Url = "https://coderwall.com/%s.json"
  
  class Badge 
    attr_reader :name, :badge, :description, :created
    
    def initialize(hashed_badge)
      @name, @badge, @description, @created = hashed_badge.values
    end
  end
  
  def CoderWally.get_badges_for(username)
      url = URI.parse(Url % username)
      puts url
      response = JSON.load(open(url))      

      response["badges"].map { |badge| Badge.new(badge) }
  end
end
