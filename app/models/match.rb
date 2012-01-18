class Match < ActiveRecord::Base
  validates :home_team, :presence => true
  validates :away_team, :presence => true

  validates :home_team_score, :presence => true, :numericality => { :only_integer => true }
  validates :away_team_score, :presence => true, :numericality => { :only_integer => true }

  validate :not_same_team

  belongs_to :league

  # allows for @match.home_team.name
  belongs_to :home_team, :class_name => 'Team', :foreign_key => "home_team"
  belongs_to :away_team, :class_name => 'Team', :foreign_key => "away_team"

  def not_same_team
    if self.home_team == self.away_team
      errors[:base] << 'Cannot record match as the same home/away team'
    end
  end
end
