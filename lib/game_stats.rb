class GameStats
  def initialize(location)
    @games = GameCollection.new(location[:games])
    @game_data = Hash.new(0)
    @goals_by_season = Hash.new(0)
    @games_by_season = Hash.new(0)
    collect_data
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

  def highest_total_score
    games.max_by do |game|
      game.total_goals
    end.total_goals
  end

  def lowest_total_score
    games.min_by do |game|
      game.total_goals
    end.total_goals
  end

  def percent_of_games(result)
    (@game_data[result] / @game_data[:total_games]).round(2)
  end

  def percentage_home_wins
    percent_of_games(:home_wins)
  end

  def percentage_visitor_wins
    percent_of_games(:away_wins)
  end

  def percentage_ties
    percent_of_games(:ties)
  end

  def average_goals_per_game
    total = @game_data[:home_goals] + @game_data[:away_goals]
    (total / @game_data[:total_games]).round(2)
  end

  def count_of_games_by_season
    @games_by_season
  end

  def average_goals_by_season
    @goals_by_season.merge(@games_by_season) do |season, goal_count, game_count|
      ((goal_count.to_f) / (game_count.to_f)).round(2)
    end
  end
end
