class TeamsMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.references :team
      t.references :member
    end
  end
end
