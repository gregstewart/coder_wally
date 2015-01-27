require "open-uri"
require "json"

module CoderWally
    class Client
         # The URL of the API we'll use.
        def api_url
          "https://coderwall.com/%s.json"
        end
        # Build user URI from username and apii url
        def uri_for_user username
          URI.parse(api_url % username)
        end
        # Dispatch the request
        def send_request url
          begin
            open(url)
          rescue OpenURI::HTTPError => error
            raise UserNotFoundError, "User not found" if  error.io.status[0] == "404"
            raise ServerError, "Server error" if  error.io.status[0] == "500"
          end
        end
        # Get badges for given user and return has collection of `Badge`s
        def get_badges_for username
          raise(ArgumentError, "Plesae provide a username") if username.empty?
          
          json_response = JSON.load(send_request(uri_for_user(username)))      
          
          json_response["badges"].map { |badge| Badge.new(badge) }
        end
    end
end

class UserNotFoundError < StandardError
end

class ServerError < StandardError
end
