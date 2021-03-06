
require_relative "./helper_test"
require 'minitest/pride'
require './lib/game_stats'

class GameStatsTest < Minitest::Test
  def setup
    @game_stats = GameStats.new('./test/data/games.csv', './test/data/teams.csv', './test/data/game_teams.csv')
  end

  def test_it_exists
    assert_instance_of GameStats, @game_stats
  end


  def test_highest_total_score
    assert_equal 6, @game_stats.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 1, @game_stats.lowest_total_score
  end

  def test_percentage_home_wins # 38 home wins in test data
    assert_equal 0.63, @game_stats.percentage_home_wins
  end

  def test_percentage_visitor_wins # 20 away wins in test data
    assert_equal 0.33, @game_stats.percentage_visitor_wins
  end

  def test_percentage_ties # 2 draws in test data
    assert_equal 0.03, @game_stats.percentage_ties
  end

  def test_count_of_games_by_season
    expected = expected = {
      "20122013"=>57,
      "20162017"=>3
    }
    assert_equal expected, @game_stats.count_of_games_by_season
  end

  def test_average_goals_per_game #235 goals in test data
    assert_equal 3.92, @game_stats.average_goals_per_game
  end

  def test_average_goals_by_season
    expected = {
      "20122013"=>3.86, # 220 goals in test data
      "20162017"=>5 # 15 goals in test data
    }
    assert_equal expected, @game_stats.average_goals_by_season
  end
end
