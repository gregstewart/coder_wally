require "open-uri"
require "json"

module CoderWally
    class Client
         # The URL of API we'll use.
        def api_url
          "https://coderwall.com/%s.json"
        end
        
        def send_request username
          url = URI.parse(api_url % username)
          
          begin
            open(url)
          rescue OpenURI::HTTPError => error
            raise UserNotFoundError, "User not found" if  error.io.status[0] == "404"
            raise ServerError, "Server error" if  error.io.status[0] == "500"
          end
        end
        
        def get_badges_for username
          raise(ArgumentError, "Plesae provide a username") if username.empty?
          
          json_response = JSON.load(send_request(username))      
          
          json_response["badges"].map { |badge| Badge.new(badge) }
        end
    end
end

class UserNotFoundError < StandardError
end

class ServerError < StandardError
end