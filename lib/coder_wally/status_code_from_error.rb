# All code in the gem is namespaced under this module.
module CoderWally
  # return status code from error object
  class StatusCodeFromError
    # Initialise object
    def initialize(error)
      @error = error
    end

    # Get the status code
    def get_status_code
      @error.io.status[0] if has_error && has_io && has_status_code
    end

    # Is there an error object?
    def has_error
      true if @error
    end

    # Is there an io object?
    def has_io
      true if @error.io
    end

    # Is there a status?
    def has_status_code
      true if @error.io.status
    end
  end
end