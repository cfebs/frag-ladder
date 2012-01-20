class Team < ActiveRecord::Base
  validates :name, :presence => true
  validates :tag, :presence => true

  has_many :home_matches, :class_name => 'Match', :foreign_key => 'home_team_id'
  has_many :away_matches, :class_name => 'Match', :foreign_key => 'away_team_id'

  has_many :team_members
  has_many :members, :through => :team_members

  has_and_belongs_to_many :leagues

  def all_matches
    home_matches + away_matches
  end
end
