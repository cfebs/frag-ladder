class MemberBelongsToTeamNoThrough < ActiveRecord::Migration
  def change
    drop_table :team_members
    add_column :members, :team_id, :integer
  end
end
