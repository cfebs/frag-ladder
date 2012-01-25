class TeamBelongsToSeason < ActiveRecord::Migration
  def change
    drop_table :seasons_teams
    add_column :teams, :season_id, :integer
  end
end
