class Team < ActiveRecord::Base
  validates :name, :presence => true
  validates :tag, :presence => true

  has_many :team_members
  has_many :members, :through => :team_members

  has_and_belongs_to_many :leagues
end
