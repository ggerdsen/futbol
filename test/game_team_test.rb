require_relative "./helper_test"
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

  def test_it_can_make_hash
    game_team = GameTeam.new({:game_id => 2012030221, :team_id => 3, :HoA => "away", :result => "LOSS", :settled_in => "OT", :head_coach => "John Tortorella", :goals => 2, :shots => 8, :tackles => 44, :pim => 8, :powerPlayOpportunities => 3, :powerPlayGoals => 0, :faceOffWinPercentage => 44.8, :giveaways => 17, :takeaways => 7})
    expected = {
                  :game_id=>2012030221,
                  :face_off_win_percentage=>nil,
                  :give_aways=>17,
                  :goals=>2,
                  :head_coach=>"John Tortorella",
                  :hoa=>nil,
                  :pim=>8,
                  :power_play_goals=>nil,
                  :power_play_opportunities=>nil,
                  :result=>"LOSS",
                  :settled_in=>"OT",
                  :shots=>8,
                  :tackles=>44,
                  :take_aways=>7,
                  :team_id=>3
                }
    assert_equal expected, game_team.to_hash
  end
end
