# All code in the gem is namespaced under this module.
module CoderWally
  # Stores user properties
  class User
    # Object properties
    attr_reader :badges, :accounts, :details

    # Initialise object with a hash of values
    def initialize(data, badges, accounts)
      @badges = badges
      @accounts = accounts
      @details = {
          name: data['name'],
          username: data['username'],
          location: data['location'],
          team: data['team'],
          endorsements: data['endorsements']
      }
    end
  end
end
