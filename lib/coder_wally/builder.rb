module CoderWally
  # Builds the CoderWall object from the response
  class Builder
    # Instantiate class
    def initialize
    end

    # parse badges from data
    def parse_badges(badges)
      badges.map { |badge| create_new_badge(badge) } if badges
    end

    # create a new badge object
    def create_new_badge(badge)
      Badge.new(badge)
    end

    # parse account information from data
    def parse_accounts(accounts)
      Account.new(accounts) if accounts
    end

    # parse user information from data
    def parse_user(data)
      badges = parse_badges(data['badges'])
      accounts = parse_accounts(data['accounts'])
      User.new(data, badges, accounts)
    end

    # build CoderWall object from API response
    def build(response)
      user = parse_user(response)

      CoderWall.new user
    end
  end
end
