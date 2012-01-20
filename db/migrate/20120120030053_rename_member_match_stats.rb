class RenameMemberMatchStats < ActiveRecord::Migration
  def change
    rename_table :member_match_stats, :member_match_records
  end
end
