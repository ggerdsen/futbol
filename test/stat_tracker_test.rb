require_relative "./helper_test"
require "./lib/stat_tracker"

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './test/data/games.csv'
    team_path = './test/data/teams.csv'
    game_teams_path = './test/data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_works
    StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_tracker_can_fetch_game_data
    assert_equal 60, @stat_tracker.games.count
    assert_instance_of Game, @stat_tracker.games.first
  end

  def test_tracker_can_fetch_team_data
    assert_equal 32, @stat_tracker.teams.count
  end

  def test_tracker_can_fetch_game_team_data
    assert_equal 52, @stat_tracker.game_teams.count
  end

  def test_it_returns_team_info_hash
    expected = {
                "team_id" => "54",
                "franchise_id" => "38",
                "team_name" => "Reign FC",
                "abbreviation" => "RFC",
                "link" => "/api/v1/teams/54"
               }
    assert_equal expected, @stat_tracker.team_info(54)
  end

  def test_it_returns_best_season_string
    assert_equal "20122013", @stat_tracker.best_season(8)
  end

  def test_it_returns_worst_season_string
    assert_equal "20122013", @stat_tracker.worst_season(8)
  end

  def test_it_returns_average_win_percentage_string
    assert_equal 0.2, @stat_tracker.average_win_percentage(8)
  end

  def test_it_can_return_most_goals_scored_integer
    assert_equal 3, @stat_tracker.most_goals_scored(16)
  end

  def test_it_can_return_fewest_goals_scored_integer
    assert_equal 0, @stat_tracker.fewest_goals_scored(16)
  end

  def test_it_can_return_favorite_opponent_string
    assert_equal "New York City FC", @stat_tracker.favorite_opponent(8)
  end

  def test_it_has_the_best_offense
     assert_equal "New York City FC", @stat_tracker.best_offense
  end

  def test_it_can_find_the_worst_offense
    assert_equal "Sporting Kansas City", @stat_tracker.worst_offense
  end

  def test_it_can_find_the_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_it_can_find_the_lowest_scoring_visitor
    assert_equal "Seattle Sounders FC", @stat_tracker.lowest_scoring_visitor
  end

  def test_it_can_find_the_highest_scoring_home_team
    assert_equal "New York City FC", @stat_tracker.highest_scoring_home_team
  end

  def test_it_can_find_the_lowest_scoring_home_team
    assert_equal "Orlando City SC", @stat_tracker.lowest_scoring_home_team
  end

  def test_highest_total_score
    assert_equal 6, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_percentage_home_wins
    assert_equal 0.63, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 0.33, @stat_tracker.percentage_visitor_wins
  end

  def test_percentage_ties
    assert_equal 0.03, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    expected = expected = {
      "20122013"=>57,
      "20162017"=>3
    }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 3.92, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    expected = {
      "20122013"=>3.86,
      "20162017"=>5
    }
    assert_equal expected, @stat_tracker.average_goals_by_season
  end

  def test_tracker_has_the_winnest_coach
    assert_equal "Claude Julien", @stat_tracker.winningest_coach("20122013")
  end

  def test_tracker_has_the_worst_coach
    assert_equal "John Tortorella", @stat_tracker.worst_coach("20122013")
  end

  def test_tracker_has_the_accurate_team
    assert_equal "New York City FC", @stat_tracker.most_accurate_team("20122013")
  end

  def test_tracker_has_the_least_accurate_team
    assert_equal "Sporting Kansas City", @stat_tracker.least_accurate_team("20122013")
  end

  def test_tracker_has_the_most_tackles
    assert_equal "New England Revolution", @stat_tracker.most_tackles("20122013")
  end

  def test_tracker_has_the_least_tackles
    assert_equal "Sporting Kansas City", @stat_tracker.fewest_tackles("20122013")
  end
end
