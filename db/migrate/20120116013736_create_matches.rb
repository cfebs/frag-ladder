class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :league
      t.integer :home_team_id
      t.integer :away_team_id
      t.integer :home_team_score
      t.integer :away_team_score
      t.boolean :approved

      t.timestamps
    end
  end
end
