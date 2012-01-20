class Member < ActiveRecord::Base
  validates :alias, :presence => true

  has_many :team_members
  has_many :teams, :through => :team_members

end
