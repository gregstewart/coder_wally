# All code in the gem is namespaced under this module.
module CoderWally
    # Stores all CoderWall properties
    class CoderWall
      attr_reader :badges, :user

      def initialize(badges, user)
        @badges = badges
        @user = user
      end
    end
end