class TeamsMembers < ActiveRecord::Migration
  def change
    create_table :teams_members do |t|
      t.references :team
      t.references :member
    end
  end
end
