require "minitest/autorun"
require "./lib/team_statistics"

class TeamStatsTest < Minitest::Test
  def setup
    @team_stats = TeamStats.new('./test/data/games.csv', './test/data/teams.csv', './test/data/game_teams.csv')
  end

  def test_it_returns_team_info_hash
    expected = {
                "team_id" => "54",
                "franchise_id" => "38",
                "team_name" => "Reign FC",
                "abbreviation" => "RFC",
                "link" => "/api/v1/teams/54"
               }
    assert_equal expected, @team_stats.team_info(54)
  end

  def test_it_returns_best_season_string
    assert_equal "20122013", @team_stats.best_season(8)
  end

  def test_it_returns_worst_season_string
    assert_equal "20122013", @team_stats.worst_season(8)
  end

  def test_it_returns_average_win_percentage_string
    assert_equal 0.2, @team_stats.average_win_percentage(8)
  end

  def test_it_can_return_most_goals_scored_integer
    assert_equal 3, @team_stats.most_goals_scored(16)
  end

  def test_it_can_return_fewest_goals_scored_integer
    assert_equal 0, @team_stats.fewest_goals_scored(16)
  end

  def test_it_can_return_favorite_opponent_string
    assert_equal "New York City FC", @team_stats.favorite_opponent(8)
  end
end
