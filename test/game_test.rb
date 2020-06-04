
require_relative "./helper_test"
require "./lib/stat_tracker"
# require './lib/game'
require 'pry'

class GameTest < Minitest::Test

  def setup
    @game = Game.new({
      :away_goals => 2,
      :away_team_id => 3,
      :date_time => "5/16/13",
      :game_id => "2012030221",
      :home_goals => 3,
      :home_team_id => 6,
      :season => "20122013",
      :type => "Postseason",
      :venue => "Toyota Stadium",
      :venue_link => "/api/v1/venues/null"
      })
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_game_has_attributes
    assert_equal 2, @game.away_goals
    assert_equal 3, @game.away_team_id
    assert_equal "5/16/13", @game.date_time
    assert_equal "2012030221", @game.game_id
    assert_equal 3, @game.home_goals
    assert_equal 6, @game.home_team_id
    assert_equal "20122013", @game.season
    assert_equal "Postseason", @game.type
    assert_equal "Toyota Stadium", @game.venue
    assert_equal "/api/v1/venues/null", @game.venue_link
  end

  def test_it_has_a_hash
    expected = {
              :game_id=>"2012030221",
              :away_goals=>2,
              :away_team_id=>3,
              :date_time=>"5/16/13",
              :home_goals=>3,
              :home_team_id=>6,
              :season=>"20122013",
              :type=>"Postseason",
              :venue=>"Toyota Stadium",
              :venue_link=>"/api/v1/venues/null"
            }
    assert_equal expected, @game.to_hash
  end
end
