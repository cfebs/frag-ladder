class Team < ActiveRecord::Base
  validates :name, :presence => true
  validates :tag, :presence => true

  has_many :matches, :foreign_key => 'home_team_id'
  has_many :matches, :foreign_key => 'away_team_id'

  has_many :team_members
  has_many :members, :through => :team_members

  has_and_belongs_to_many :leagues
end
