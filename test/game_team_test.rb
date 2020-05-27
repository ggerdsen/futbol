require "simplecov"
SimpleCov.start
require "minitest/autorun"
require "./lib/game_team"

class GameTeamTest < MiniTest::Test

  def test_it_exists
    game_team = GameTeam.new({:game_id => 2012030221, :team_id => 3, :HoA => "away", :result => "LOSS", :settled_in => "OT", :head_coach => "John Tortorella", :goals => 2, :shots => 8, :tackles => 44, :pim => 8, :powerPlayOpportunities => 3, :powerPlayGoals => 0, :faceOffWinPercentage => 44.8, :giveaways => 17, :takeaways => 7})
    assert_instance_of GameTeam, game_team
  end

  def test_it_has_attributes
    game_team = GameTeam.new({:game_id => 2012030221, :team_id => 3, :HoA => "away", :result => "LOSS", :settled_in => "OT", :head_coach => "John Tortorella", :goals => 2, :shots => 8, :tackles => 44, :pim => 8, :powerPlayOpportunities => 3, :powerPlayGoals => 0, :faceOffWinPercentage => 44.8, :giveaways => 17, :takeaways => 7})
    assert_equal 2012030221, game_team.game_id
  end

end
