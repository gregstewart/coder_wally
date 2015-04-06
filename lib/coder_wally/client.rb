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
    def get_badges_for(username)
      warn '[DEPRECATION] `get_badges_for` is deprecated.  Please use `user.badges` instead.'
      @coder_wall.user.badges
    end

    # Get user details for given user and return a `User` object
    def get_details_for(username)
      warn '[DEPRECATION] `get_details_for` is deprecated.  Please use `user.details` instead.'
      @coder_wall.user.details
    end

    # Get all the information available for a given user,
    # returns a `CoderWall` object
    def get_everything_for(username)
      warn '[DEPRECATION] `get_everything_for` is deprecated.  Please use `user` instead.'
      @coder_wall
    end

    def user
      @coder_wall.user
    end

    # Builds a CoderWall object
    def build_coder_wall_from_response(username)
      json_response = @api.fetch(username)

      @builder.build(json_response)
    end
  end
end
