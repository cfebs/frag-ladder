class TeamsMembers < ActiveRecord::Migration
  def change
    create_table :members_teams do |t|
      t.references :team
      t.references :member
    end
  end
end
