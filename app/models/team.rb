class Team < ActiveRecord::Base
  WIN_VALUE = 3
  TIE_VALUE = 1
  LOSS_VALUE = 0

  FIRST_PLAY_BONUS = 1

  HANDICAP_TIE_BONUS = 1
  HANDICAP_LOSS_BONUS = 1

  PHASE_TWO_DATE = Time.now + 2.weeks

  validates :name, :presence => true
  validates :tag, :presence => true

  has_many :home_matches, :class_name => 'Match', :foreign_key => 'home_team_id'
  has_many :away_matches, :class_name => 'Match', :foreign_key => 'away_team_id'

  has_many :team_members
  has_many :members, :through => :team_members

  has_and_belongs_to_many :seasons

  def all_matches
    Match.where('home_team_id = ? or away_team_id = ?', self.id, self.id)
  end

  def wins
    self.all_matches.where('(home_team_id = ? AND home_team_score > away_team_score)
      OR (away_team_id = ? AND away_team_score > away_team_score)', self.id, self.id)
  end

  def losses
    self.all_matches.where('(home_team_id = ? AND home_team_score < away_team_score)
      OR (away_team_id = ? AND away_team_score < away_team_score)', self.id, self.id)
  end

  def ties
    self.all_matches.where('(home_team_id = ? AND home_team_score = away_team_score)
      OR (away_team_id = ? AND away_team_score = away_team_score)', self.id, self.id)
  end

  def win_percentage
    (self.wins.length / self.all_matches.length) if !self.all_matches.empty?
    return 0
  end

  # First Play Matches
  def first_play_wins
    self.wins.select('distinct home_team_id, away_team_id')
  end

  def first_play_losses
    self.losses.select('distinct home_team_id, away_team_id')
  end

  def first_play_ties
    self.ties.select('distinct home_team_id, away_team_id')
  end

  # Handicap Matches
  def handicap_losses
    self.losses.where('created_at > ?', PHASE_TWO_DATE)
  end

  def handicap_ties
    self.losses.where('created_at > ?', PHASE_TWO_DATE)
  end

  # Point calculations

  def wins_plus_bonus
    self.first_play_wins.length * FIRST_PLAY_BONUS + self.wins.length * WIN_VALUE
  end

  def ties_plus_bonus
    self.first_play_ties.length * FIRST_PLAY_BONUS +
      self.handicap_ties.length * HANDICAP_TIE_BONUS +
      self.ties.length * TIE_VALUE
  end

  def losses_plus_bonus
    self.first_play_losses.length * FIRST_PLAY_BONUS +
      self.handicap_losses.length * HANDICAP_LOSS_BONUS
  end

  def total_points
    self.wins_plus_bonus + self.ties_plus_bonus + self.losses_plus_bonus
  end
end
