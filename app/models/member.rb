class Member < ActiveRecord::Base
  validates :alias, :presence => true
  validate :unique_alias_in_team

  has_many :team_members
  has_many :teams, :through => :team_members

  def unique_alias_in_team
  end
end
