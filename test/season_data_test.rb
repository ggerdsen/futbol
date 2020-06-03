require "simplecov"
SimpleCov.start
require "minitest/autorun"
require "./lib/season_data"

class SeasonStatsTest < Minitest::Test
  def setup
    @season = SeasonStats.new('./test/data/games.csv', './test/data/teams.csv', './test/data/game_teams.csv')
  end
  def test_it_exist
    assert_instance_of SeasonStats, @season
  end

  def test_tracker_has_all_games_per_season
    assert_equal 57, @season.all_games_per_season("20122013").count
    assert_instance_of Game,  @season.all_games_per_season("20122013").first

    expected = @season.all_games_per_season("20122013").map{|game| game.season}.uniq
    assert_equal 1, expected.size
    assert_equal "20122013", expected.first
  end


  def test_tracker_has_all_game_teams_per_season
    game_teams_in_a_season = @season.all_game_teams_per_season("20122013")
    assert_equal 52, game_teams_in_a_season.count

    game_teams_in_a_season.each do |game_team|
      assert_instance_of GameTeam, game_team
    end
  end

  def test_tracker_has_all_games_by_head_coach
     expected_list_of_coaches = ["John Tortorella",
      "Claude Julien",
      "Dan Bylsma",
      "Mike Babcock",
      "Joel Quenneville",
      "Paul MacLean",
      "Michel Therrien",
      "Mike Yeo"
    ]
    assert_kind_of Hash, @season.games_by_head_coach("20122013")
    assert_equal expected_list_of_coaches, @season.games_by_head_coach("20122013").keys
  end

  def test_tracker_can_group_coach_with_win_counts
    expected = {
        "John Tortorella"=>0,
        "Claude Julien"=>9,
        "Dan Bylsma"=>0,
        "Mike Babcock"=>4,
        "Joel Quenneville"=>7,
        "Paul MacLean"=>3,
        "Michel Therrien"=>1,
        "Mike Yeo"=>1
      }
    assert_equal expected, @season.coach_per_total_win("20122013")
  end

  def test_tracker_has_the_winnest_coach
    assert_equal "Claude Julien", @season.winningest_coach("20122013")
  end

  def test_tracker_has_the_worst_coach
    assert_equal "John Tortorella", @season.worst_coach("20122013")
  end

  def test_tracker_has_games_per_team_ids_for_a_season
    assert_kind_of  Hash, @season.team_id_group("20122013")
  end

  def test_tracker_has_ratio_of_shots_per_season
    expected = {
                 "3"=>21.05,
                 "6"=>31.58,
                 "5"=>6.25,
                 "17"=>28.26,
                 "16"=>23.23,
                 "9"=>38.89,
                 "8"=>20.93,
                 "30"=>21.21
               }

    assert_equal expected, @season.ratio_of_shots("20122013")
    assert_equal "9", @season.best_accurate_team_id("20122013")
    assert_equal "5", @season.least_accurate_team_id("20122013")
  end

  def test_tracker_can_find_team_by_id
    assert_instance_of Team , @season.find_team_by_id("5")
     assert_equal "Sporting Kansas City", @season.find_team_by_id("5").team_name
  end

  def test_tracker_has_the_accurate_team
    assert_equal "New York City FC", @season.most_accurate_team("20122013")
  end

  def test_tracker_has_the_accurate_team
    assert_equal "Sporting Kansas City", @season.least_accurate_team("20122013")
  end

  def test_tracker_has_total_tackles_per_season
    expected = {
      "3"=>179,
      "6"=>271,
      "5"=>150,
      "17"=>219,
      "16"=>299,
      "9"=>181,
      "8"=>173,
      "30"=>165
    }
    assert_equal expected, @season.total_tackles_team_per_season("20122013")
  end

  def test_tracker_can_get_team_name_with_id
    assert_equal "Sporting Kansas City", @season.find_team_by_id("5").team_name
  end

  def test_tracker_has_the_most_tackles
    assert_equal "New England Revolution", @season.most_tackles("20122013")
  end

  def test_tracker_has_the_least_tackles
    assert_equal "Sporting Kansas City", @season.fewest_tackles("20122013")
  end
end
