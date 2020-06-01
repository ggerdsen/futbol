
class DataCollector
  attr_reader :game_data, :goals_by_season, :games_by_season
  def initialize(location)
    @games = GameCollection.new(location[:games])
    @game_data = Hash.new(0)
    @goals_by_season = Hash.new(0)
    @games_by_season = Hash.new(0)
  end

  def games
    @games.all
  end

  def collect_data
    games.each do |game|
      @game_data[:total_games] += 1.0
      @game_data[:home_wins] += 1.0 if game.home_goals > game.away_goals
      @game_data[:away_wins] += 1.0 if game.away_goals > game.home_goals
      @game_data[:ties] += 1.0 if game.home_goals == game.away_goals
      @game_data[:home_goals] += game.home_goals
      @game_data[:away_goals] += game.away_goals
      @games_by_season[game.season] += 1
      @goals_by_season[game.season] += game.total_goals
    end
    @game_data
  end
end
