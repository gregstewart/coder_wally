# All code in the gem is namespaced under this module.
module CoderWally
  # Stores the users accounts
  class Account
    # Dynamically create account properties
    def initialize(collection_of_accounts)
      collection_of_accounts.each do |account, value|
        singleton_class.class_eval do; attr_accessor "#{account}"; end
        self.instance_variable_set("@#{account}", value)
      end
    end
  end
end