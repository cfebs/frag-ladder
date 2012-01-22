class Team < ActiveRecord::Base
  WIN_VALUE = 3
  TIE_VALUE = 1
  LOSS_VALUE = 0

  FIRST_PLAY_BONUS = 1

  HANDICAP_TIE_BONUS = 1
  HANDICAP_LOSS_BONUS = 1

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

  # First Play Matches
  def first_play_wins
    self.wins.select('distinct(home_team_id, away_team_id)')
  end

  def first_play_wins
    self.losses.select('distinct(home_team_id, away_team_id)')
  end

  def first_play_ties
    self.ties.select('distinct(home_team_id, away_team_id)')
  end

  # Handicap Matches
  def handicap_losses
    self.losses.where('created_at > ?', Season.phase_two_date)
  end

  def handicap_ties
    self.losses.where('created_at > ?', Season.phase_two_date)
  end

  # Point calculations

  def wins_plus_bonus
    self.first_play_wins * FIRST_PLAY_BONUS + self.wins * WIN_POINTS
  end

  def ties_plus_bonus
    self.first_play_ties * FIRST_PLAY_BONUS +
      self.handicap_ties * HANDICAP_TIE_BONUS +
      self.ties * TIE_POINTS
  end

  def losses_plus_bonus
    self.first_play_losses * FIRST_PLAY_BONUS +
      self.handicap_losses * HANDICAP_LOSS_BONUS
  end

  def points
    self.wins_plus_bonus + self.ties_plus_bonus + self.losses_plus_bonus
  end
end
