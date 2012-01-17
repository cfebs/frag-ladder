class LeaguesTeams < ActiveRecord::Migration
  def change
    create_table :leagues_teams do |t|
      t.references :league
      t.references :team
    end
  end
end
