class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :league
      t.integer :home_team
      t.integer :away_team
      t.integer :home_team_score
      t.integer :away_team_score
      t.boolean :approved

      t.timestamps
    end
  end
end
