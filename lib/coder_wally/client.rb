module CoderWally
  # Client to access the API
  class Client
    # Instantiate class
    def initialize(username)
      @api = API.new
      @builder = Builder.new
      @coder_wall = build_coder_wall_from_response(username)
    end

    # Get badges for given user and return has collection of `Badge`s
    def get_badges_for(*username)
      deprecation_message("get_badges_for(#{username})",'user.badges')
      @coder_wall.user.badges
    end

    # Get user details for given user and return a `User` object
    def get_details_for(*username)
      deprecation_message("get_details_for(#{username})",'user.details')
      @coder_wall.user.details
    end

    # Get all the information available for a given user,
    # returns a `CoderWall` object
    def get_everything_for(*username)
      deprecation_message("get_everything_for(#{username})",'user')
      @coder_wall
    end

    # Get all the information for a given user
    # Returns a user object
    def user
      @coder_wall.user
    end

    private

    # Builds a CoderWall object
    def build_coder_wall_from_response(username)
      json_response = @api.fetch(username)

      @builder.build(json_response)
    end

    # displaying a warning message that the API method is deprecated
    def deprecation_message(old, new)
      warn "[DEPRECATION] `#{old}` is deprecated.  Please use `#{new}` instead."
    end

  end
end
