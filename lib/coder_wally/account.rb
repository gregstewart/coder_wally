# All code in the gem is namespaced under this module.
module CoderWally
  # Stores the users accounts
  class Account
    # Dynamically create account properties
    def initialize(collection_of_accounts)
      collection_of_accounts.each do |account, value|
        create_accessor account
        set_accessor_value account, value
      end
    end
    # create the attribute accessor
    def create_accessor(name)
      singleton_class.class_eval { attr_accessor "#{name}" }
    end
    # assign the value to the accessor
    def set_accessor_value(name, value)
      instance_variable_set("@#{name}", value)
    end
  end
end
