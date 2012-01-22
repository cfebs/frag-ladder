class Team < ActiveRecord::Base
  validates :name, :presence => true
  validates :tag, :presence => true

  has_many :home_matches, :class_name => 'Match', :foreign_key => 'home_team_id'
  has_many :away_matches, :class_name => 'Match', :foreign_key => 'away_team_id'

  has_many :team_members
  has_many :members, :through => :team_members

  has_and_belongs_to_many :seasons

  def all_matches
    self.home_matches + self.away_matches
  end

  def wins
    self.home_matches.where("home_team_score > away_team_score") +
      self.away_matches.where("away_team_score > home_team_score")
  end

  def losses
    self.home_matches.where("home_team_score < away_team_score") +
      self.away_matches.where("away_team_score < home_team_score")
  end

  def ties
    self.all_matches.where("home_team_score = away_team_score")
  end

  def win_percentage
    (self.wins.length / self.all_matches.length) if !self.all_matches.empty?
    return 0
  end
end
