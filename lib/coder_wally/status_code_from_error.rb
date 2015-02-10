# All code in the gem is namespaced under this module.
module CoderWally
  # return status code from error object
  class StatusCodeFromError
    # Initialise object
    def initialize(error)
      @error = error
    end

    # Get the status code
    def status_code
      @error.io.status[0] if error? && io? && status_code?
    end

    # Is there an error object?
    def error?
      true if @error
    end

    # Is there an io object?
    def io?
      true if @error.io
    end

    # Is there a status?
    def status_code?
      true if @error.io.status
    end
  end
end
