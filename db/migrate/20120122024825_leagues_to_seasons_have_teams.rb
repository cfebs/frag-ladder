class LeaguesToSeasonsHaveTeams < ActiveRecord::Migration
  def change
    rename_table :leagues_teams, :seasons_teams
    rename_column :seasons_teams, :league_id, :season_id
  end
end
