
class Game
  attr_reader :game_id, :home_goals, :home_team_id, :season,
              :type, :date_time, :away_goals, :away_team_id,
              :venue, :venue_link, :total_goals
  def initialize(data)
    @game_id = data[:game_id]
    @season = data[:season]
    @type = data[:type]
    @date_time = data[:date_time]
    @away_team_id = data[:away_team_id]
    @home_team_id = data[:home_team_id]
    @away_goals = data[:away_goals].to_i
    @home_goals = data[:home_goals].to_i
    @venue = data[:venue]
    @venue_link = data[:venue_link]
    @total_goals = @away_goals + @home_goals
  end

  def to_hash
    {game_id: @game_id, away_goals: @away_goals, away_team_id: @away_team_id,
      date_time: @date_time, home_goals: @home_goals, home_team_id:
      @home_team_id, season: @season, type: @type, venue: @venue, venue_link:
      @venue_link}
  end
end
