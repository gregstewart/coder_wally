module CoderWally
  # Builds the CoderWall object from the response
  class Builder
    # Instantiate class
    def initialize
    end

    # parse badges from data
    def parse_badges(badges)
      badges.map { |badge| Badge.new(badge) } if badges
    end

    # parse account information from data
    def parse_accounts(accounts)
      Account.new(accounts) if accounts
    end

    # parse user information from data
    def parse_user(data)
      User.new(data)
    end

    # build CoderWall object from API response
    def build(response)
      badges = parse_badges(response['badges'])
      accounts = parse_accounts(response['accounts'])
      user = parse_user(response)

      CoderWall.new badges, user, accounts
    end
  end
end
