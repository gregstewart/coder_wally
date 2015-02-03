require 'open-uri'
require 'json'

module CoderWally
  class API
    def fetch(username)
      uri = uri_for_user(username)
      JSON.load(send_request(uri))
    end

    private
      # Dispatch the request
      def send_request(url)
        begin
          open(url)
        rescue OpenURI::HTTPError => error
          handle_user_not_found_error(error)
          handle_server_error(error)
        end
      end

      # Parse status code from error
      def get_status_code(error)
        error.io.status[0]
      end

      # Raise server error
      def handle_server_error(error)
        raise ServerError, 'Server error' if  get_status_code(error) == '500'
      end

      # Raise user not found error
      def handle_user_not_found_error(error)
        raise UserNotFoundError, 'User not found' if  get_status_code(error) == '404'
      end

      # Build user URI from username and api url
      def uri_for_user(username)
        raise(ArgumentError, 'Please provide a username') if username.empty?

        URI.parse(api_url % username)
      end

      # The URL of the API we'll use.
      def api_url
        'https://coderwall.com/%s.json'
      end
  end
end
# Handles user not found exception
class UserNotFoundError < StandardError
end

# Handles server exception
class ServerError < StandardError
end