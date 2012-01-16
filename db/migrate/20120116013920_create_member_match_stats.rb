class CreateMemberMatchStats < ActiveRecord::Migration
  def change
    create_table :member_match_stats do |t|
      t.references :member
      t.references :match
      t.integer :kills
      t.integer :deaths
      t.integer :points

      t.timestamps
    end
  end
end
