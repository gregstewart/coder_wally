# All code in the gem is namespaced under this module.
module CoderWally
    # Stores user properties
    class User 
        # Object properties 
        attr_reader :name, :username, :location, :team
        
        # Initialise object with a hash of values
        def initialize(name, username, location, team)
          @name = name
          @username = username
          @location = location 
          @team = team
        end
    end
end