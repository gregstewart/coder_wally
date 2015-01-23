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
      @name = hashed_badge.fetch("name")
      @badge = hashed_badge.fetch("badge")
      @description = hashed_badge.fetch("description") 
      @created = hashed_badge.fetch("created")
    end
  end
  
  def CoderWally.get_badges_for username
    raise(ArgumentError, "Plesae provide a username") if username.empty?
    url = URI.parse(Url % username)
    response = JSON.load(open(url))      

    response["badges"].map { |badge| Badge.new(badge) }
  end
end
