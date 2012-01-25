class AddMapIdToMatches < ActiveRecord::Migration
  def up
    add_column :matches, :map_id, :integer
    remove_column :member_match_records, :kills
    remove_column :member_match_records, :deaths
    remove_column :member_match_records, :points
  end

  def down
    remove_column :matches, :map_id
    add_column :member_match_records, :kills, :integer
    add_column :member_match_records, :deaths, :integer
    add_column :member_match_records, :points, :integer
  end
end
