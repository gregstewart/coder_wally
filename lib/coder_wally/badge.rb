# All code in the gem is namespaced under this module.
module CoderWally
  # Stores Badge properties
  class Badge
    # Object properties
    attr_reader :name, :badge, :description, :created

    # Initialise object with a hash of values
    def initialize(hashed_badge)
      @name = hashed_badge.fetch('name')
      @badge = hashed_badge.fetch('badge')
      @description = hashed_badge.fetch('description')
      @created = hashed_badge.fetch('created')
    end
  end
end
