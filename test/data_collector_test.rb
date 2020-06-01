require './lib/game'
require './lib/data_collector'
require './lib/game_collection'
require 'minitest/autorun'
require 'minitest/pride'

class DataCollectorTest < Minitest::Test
  def setup
    game_path = './test/data/games.csv'
    team_path = './test/data/teams.csv'
    game_teams_path = './test/data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @data_collector = DataCollector.new(locations)
  end

  def test_it_exists
    assert_instance_of DataCollector, @data_collector
  end

  def test_it_has_attributes
    assert_instance_of Game, @data_collector.games.first
  end

  def test_it_can_collect_data
    @data_collector.collect_data
    assert_equal 60,@data_collector.game_data[:total_games]
    assert_equal 38, @data_collector.game_data[:home_wins]
    assert_equal 20, @data_collector.game_data[:away_wins]
    assert_equal 2, @data_collector.game_data[:ties]
  end
end
