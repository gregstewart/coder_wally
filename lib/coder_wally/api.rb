require 'open-uri'
require 'json'

module CoderWally
  # API Class
  class API
    # Fetch data from CoderWall
    def fetch(username)
      uri = uri_for_user(username)
      json = send_request(uri)

      begin
        JSON.parse(json.read)
      rescue JSON::ParserError
        raise InvalidJson, 'Received invalid json in response'
      end
    end

  private
    # Dispatch the request
    def send_request(url)
      open(url)
    rescue OpenURI::HTTPError => error
      ExceptionHandler.new(error)
    end

    # Build user URI from username and api url
    def uri_for_user(username)
      fail ArgumentError, 'Please provide a username' if username.empty?

      URI.parse(api_url % username)
    end

    # The URL of the API we'll use.
    def api_url
      'https://coderwall.com/%s.json'
    end
  end
end

# Handles bad JSON
class InvalidJson < StandardError
end
