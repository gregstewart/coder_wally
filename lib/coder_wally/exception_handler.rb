module CoderWally
  # Raises errors from the service request
  class ExceptionHandler
    # Initialize with the error object
    def initialize(error)
      status_code = StatusCodeFromError.new(error).status_code
      fail ServerError, 'Server error' if status_code == '500'
      fail UserNotFoundError, 'User not found' if status_code == '404'
    end
  end
end
# Handles user not found exception
class UserNotFoundError < StandardError
end

# Handles server exception
class ServerError < StandardError
end
