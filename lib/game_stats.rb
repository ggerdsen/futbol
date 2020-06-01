class GameStats < DataCollector
  def initialize(location)
    super(location)
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
