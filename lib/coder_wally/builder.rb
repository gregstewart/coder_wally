module CoderWally
  # Builds the CoderWall object from the response
  class Builder
    # Instantiate class
    def initialize
    end

    # parse badges from data
    def parse_badges(data)
      data['badges'].map { |badge| Badge.new(badge) } if data['badges']
    end

    # parse account information from data
    def parse_accounts(data)
      Account.new(data['accounts']) if data['accounts']
    end

    # parse user information from data
    def parse_user(data)
      User.new(data['name'], data['username'],
               data['location'], data['team'], data['endorsements'])
    end

    # build CoderWall object from API response
    def build response
      badges = parse_badges(response)
      accounts = parse_accounts(response)
      user = parse_user(response)

      CoderWall.new badges, user, accounts
    end
  end
end
