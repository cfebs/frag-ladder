class Match < ActiveRecord::Base
  validates :home_team, :presence => true
  validates :away_team, :presence => true

  validates :home_team_score, :presence => true, :numericality => { :only_integer => true }
  validates :away_team_score, :presence => true, :numericality => { :only_integer => true }

  validate :not_same_team

  belongs_to :season
  belongs_to :map

  belongs_to :home_team, :class_name => 'Team', :foreign_key => "home_team_id"
  belongs_to :away_team, :class_name => 'Team', :foreign_key => "away_team_id"

  has_many :member_match_records
  accepts_nested_attributes_for :member_match_records

  def tie?
    home_team_score == away_team_score
  end

  def phase
    '1'
  end

  def not_same_team
    if self.home_team == self.away_team
      errors[:base] << 'Cannot record match as the same home/away team'
    end
  end

  def home_team_members
    self.home_team.members
  end

  def away_team_members
    self.away_team.members
  end

  def home_records
    recs = []
    home_ids = self.home_team_members.collect {|m| m.id}
    self.member_match_records.each do |r|
      recs << r if home_ids.include?(r.member_id)
    end
    return recs
  end

  def away_records
    recs = []
    away_ids = self.away_team_members.collect {|m| m.id}
    self.member_match_records.each do |r|
      recs << r if away_ids.include?(r.member_id)
    end
    return recs
  end

  def get_plus team
    self.team_score team
  end

  def get_minus team
    self.opponent_score team
  end

  def team_score team
    if self.home_team_id == team.id
      self.home_team_score
    else
      self.away_team_score
    end
  end

  def opponent_score team
    if self.home_team_id == team.id
      self.away_team_score
    else
      self.home_team_score
    end
  end


end
