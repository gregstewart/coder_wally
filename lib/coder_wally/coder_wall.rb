# All code in the gem is namespaced under this module.
module CoderWally
  # Stores all CoderWall attributes
  class CoderWall
    # :badges is the collection of user badges
    # :user is the `User` object
    # :accounts is the `Account` object
    attr_reader :badges, :user, :accounts

    # Instantiate the class with data
    def initialize(badges, user, accounts)
      @badges = badges
      @user = user
      @accounts = accounts
    end
  end
end
