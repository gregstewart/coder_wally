# All code in the gem is namespaced under this module.
module CoderWally
    # Stores all CoderWall attributes
    class CoderWall
      # :badges is the collection of user badges
      # :user is the `User` object
      attr_reader :badges, :user

      # Instantiate the class with data
      def initialize(badges, user)
        @badges = badges
        @user = user
      end
    end
end