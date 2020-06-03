require_relative "./helper_test"
require "minitest/autorun"
require "./lib/league"

class LeagueStatsTest < Minitest::Test
  def setup
    @league = LeagueStats.new('./test/data/games.csv', './test/data/teams.csv', './test/data/game_teams.csv')
  end


  def test_it_can_count_teams
    assert_equal 32, @league.count_of_teams
  end

  def test_it_can_find_team_by_id
    # skip
    assert_equal "Toronto FC", @league.find_team_by_id(20).team_name
  end

  def test_it_has_the_best_offense
    # skip
     assert_equal "New York City FC", @league.best_offense
  end

  def test_it_can_find_the_worst_offense
    # skip
    assert_equal "Sporting Kansas City", @league.worst_offense
  end

  def test_it_can_find_the_highest_scoring_visitor
    # skip
    assert_equal "FC Dallas", @league.highest_scoring_visitor
  end

  def test_it_can_find_the_lowest_scoring_visitor
    # skip
    assert_equal "Seattle Sounders FC", @league.lowest_scoring_visitor
  end

  def test_it_can_find_the_highest_scoring_home_team
    # skip
    assert_equal "New York City FC", @league.highest_scoring_home_team
  end

  def test_it_can_find_the_lowest_scoring_home_team
    # skip
    assert_equal "Orlando City SC", @league.lowest_scoring_home_team
  end
end
