# All code in the gem is namespaced under this module.
module CoderWally
  # Stores user properties
  class User
    # Object properties
    attr_reader :name, :username, :location, :team, :endorsements

    # Initialise object with a hash of values
    def initialize(data)
      @name = data['name']
      @username = data['username']
      @location = data['location']
      @team = data['team']
      @endorsements = data['endorsements']
    end
  end
end
