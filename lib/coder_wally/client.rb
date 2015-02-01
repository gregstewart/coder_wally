require "open-uri"
require "json"

module CoderWally
    # Client to access the API
    class Client
         # The URL of the API we'll use.
        def api_url
          "https://coderwall.com/%s.json"
        end
        # Build user URI from username and apii url
        def uri_for_user username
          raise(ArgumentError, "Plesae provide a username") if username.empty?
          
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
          json_response = JSON.load(send_request(uri_for_user(username)))      
          
          json_response["badges"].map { |badge| Badge.new(badge) }
        end
        
        # Get user details for given user and return a `User` object
        def get_details_for username
          json_response = JSON.load(send_request(uri_for_user(username)))      
        
          User.new(json_response["name"], json_response["username"],
            json_response["location"], json_response["team"])
        end
        
        def get_everything_for username
          json_response = JSON.load(send_request(uri_for_user(username)))      
          # (json_response)
          CoderWall.new
        end
    end
end

# Handles user not found exception
class UserNotFoundError < StandardError
end

# Handles server exception
class ServerError < StandardError
end
