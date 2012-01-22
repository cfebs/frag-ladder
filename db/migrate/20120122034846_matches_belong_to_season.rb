class MatchesBelongToSeason < ActiveRecord::Migration
  def change
    rename_column :matches, :league_id, :season_id
  end
end
