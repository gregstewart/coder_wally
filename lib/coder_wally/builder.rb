module CoderWally
  class Builder
    def initialize
    end

    def parse_badges(json_response)
      json_response['badges'].map { |badge| Badge.new(badge) }
    end

    def parse_accounts(json_response)
      Account.new(json_response['accounts'])
    end

    def parse_user(json_response)
      User.new(json_response['name'], json_response['username'],
               json_response['location'], json_response['team'], json_response['endorsements'])
    end

    def build response
      badges = parse_badges(response)
      accounts = parse_accounts(response)
      user = parse_user(response)

      CoderWall.new badges, user, accounts
    end

  end
end
