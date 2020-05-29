
require "csv"
require_relative "./game_collection"
require_relative "./team_collection"
require_relative "./game_team_collection"

class StatTracker

  def initialize(location)
    @games = GameCollection.new(location[:games])
    @teams = TeamCollection.new(location[:teams])
    @game_teams = GameTeamCollection.new(location[:game_teams])
  end
  def self.from_csv(location)
    StatTracker.new(location)
  end

  def games
    @games.all
  end

  def teams
    @teams.all
  end

  def game_teams
    @game_teams.all
  end
  ###################
  ## SEASON METHODS##
  ###################

  def all_games_per_season(season_id)
    games.select do |game|
      game.season.eql?(season_id)
    end
  end

  def all_game_teams_per_season(season_id)
    game_teams.select do |game_team|
      all_games_per_season(season_id).any? do |game|
        game.game_id.eql?game_team.game_id
       end
    end
  end

  def games_by_head_coach(season_id)
    all_game_teams_per_season(season_id).group_by do |game_team|
      game_team.head_coach
    end
  end

  def coach_per_total_win(season_id)
    coach_win_count = {}
    games_by_head_coach(season_id).each do |coach, games|
      winning_games = games.select{|game| game.result == "WIN"}
      if winning_games.length.zero?
         coach_win_count[coach] = 0
      else
        coach_win_count[coach] = winning_games.size
      end
    end
    coach_win_count
  end

  def winningest_coach(season_id)
    highest_coach = coach_per_total_win(season_id).max_by do |coach, total_winning_games|
      total_winning_games
    end
    highest_coach.first
  end

  def worst_coach(season_id)
    lowest_coach = coach_per_total_win(season_id).min_by do |coach, total_winning_games|
      total_winning_games
    end
    lowest_coach.first
  end

  def team_id_group(season_id)
    x = all_game_teams_per_season(season_id).group_by do |game_team|
      game_team.team_id
    end
  end

  def ratio_of_shots(season_id)
    hash ={}
    team_id_group(season_id).each do |key, value|
       hash[key] = (value.sum{|g| g.shots.to_f}/value.sum{|g| g.goals.to_f}).round(2)
    end
    hash
  end

  def team_id_best(season_id)
    max = ratio_of_shots(season_id).max_by{|team_id, ratio| ratio}
    max.first
  end

  def team_id_worst(season_id)
    min = ratio_of_shots(season_id).min_by{|team_id, ratio| ratio}
    min.first
  end

  def find_team_by_id(team_id)
    teams.find {|team| team.team_id == team_id}
  end

  def most_accurate_team(season_id)
    team_f = find_team_by_id(team_id_best(season_id))
    team_f.team_name
  end

  def least_accurate_team(season_id)
    team_f = find_team_by_id(team_id_worst(season_id))
    team_f.team_name
  end
end
