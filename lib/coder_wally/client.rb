module CoderWally
    # Client to access the API
    class Client
        # Instantiate class
        def initialize
          @api = API.new
          @builder = Builder.new
        end

        # Get badges for given user and return has collection of `Badge`s
        def get_badges_for username
          coder_wall = build_coder_wall_from_response(username)
          coder_wall.badges
        end
        
        # Get user details for given user and return a `User` object
        def get_details_for username
          coder_wall = build_coder_wall_from_response(username)
          coder_wall.user
        end

        # Get all the information available for a given user, returns a `CoderWall` object
        def get_everything_for username
          build_coder_wall_from_response(username)
        end

        # Builds a CoderWall object
        def build_coder_wall_from_response(username)
          json_response = @api.fetch(username)

          @builder.build(json_response)
        end
    end
end
