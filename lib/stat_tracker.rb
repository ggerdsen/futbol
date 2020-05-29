
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
    x = games.select do |game|
      game.season.eql?(season_id)
    end
  end

  def all_game_teams_per_season(season_id)
    game_ids_per_season = all_games_per_season(season_id).group_by {|game| game.game_id}.keys
    game_teams.select do |game_team|
      game_ids_per_season.include?(game_team.game_id)
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

  def team_id_group(season_id)#
    all_game_teams_per_season(season_id).group_by do |game_team|
      game_team.team_id
    end
  end

  def ratio_of_shots(season_id)#
    hash ={}
    team_id_group(season_id).each do |team_id, value|
      total_shots = value.sum{|game| game.shots.to_f}
      total_goals = value.sum{|game| game.goals.to_f}
       hash[team_id] = (total_goals/total_shots *100).round(2)
    end
    hash
  end

  def best_accurate_team_id(season_id)#
    max = ratio_of_shots(season_id).max_by{|team_id, ratio| ratio}
    max.first
  end

  def least_accurate_team_id(season_id)#
    min = ratio_of_shots(season_id).min_by{|team_id, ratio| ratio}
    min.first
  end

  def find_team_by_id(team_id)#
    teams.find {|team| team.team_id == team_id}
  end

  def most_accurate_team(season_id)
    team_f = find_team_by_id(best_accurate_team_id(season_id))
    team_f.team_name
  end

  def least_accurate_team(season_id)
    team_f = find_team_by_id(least_accurate_team_id(season_id))
    team_f.team_name
  end

  def most_tackles(season_id)
    hash = {}
    team_id_group(season_id).each do |team_id, value|
      hash[team_id] = value.sum{|g| g.tackles.to_i}
    end
    hash
    max_id = hash.max_by {|key, value| value}.first

    team_f = find_team_by_id(max_id)
    team_f.team_name
  end

  def fewest_tackles(season_id)
    hash = {}
    team_id_group(season_id).each do |team_id, value|
      hash[team_id] = value.sum{|g| g.tackles.to_i}
    end
    hash
    min_id = hash.min_by {|key, value| value}.first

    team_f = find_team_by_id(min_id)
    team_f.team_name
  end
end
