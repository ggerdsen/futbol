
require_relative "./team_statistics"

class StatTracker < TeamStats
  def self.from_csv(location)
    StatTracker.new(location[:games], location[:teams], location[:game_teams])
  end
end
