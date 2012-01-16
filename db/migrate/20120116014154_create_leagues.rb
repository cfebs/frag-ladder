class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.references :game
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end
end
