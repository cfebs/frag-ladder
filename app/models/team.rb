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

  has_many :members

  belongs_to :seasons

  # match functions
  def win? match
    if self.wins.include?(match)
      true
    else
      false
    end
  end

  def win_or_loss match
    if self.win? match
      return 'win'
    else
      return 'loss'
    end
  end

  def get_plus match
      self.match_score match
  end

  def get_minus match
      self.opponent_score match
  end

  def match_score match
    if match.home_team_id == self.id
      match.home_team_score
    else
      match.away_team_score
    end
  end

  def opponent_score match
    if match.home_team_id == self.id
      match.away_team_score
    else
      match.home_team_score
    end
  end



  def all_matches
    Match.where('home_team_id = ? or away_team_id = ?', self.id, self.id)
  end

  def wins
    self.all_matches.where('(home_team_id = ? AND home_team_score > away_team_score)
      OR (away_team_id = ? AND away_team_score > home_team_score)', self.id, self.id)
  end

  def losses
    self.all_matches.where('(home_team_id = ? AND home_team_score < away_team_score)
      OR (away_team_id = ? AND away_team_score < home_team_score)', self.id, self.id)
  end

  def ties
    self.all_matches.where('(home_team_id = ? AND home_team_score = away_team_score)
      OR (away_team_id = ? AND away_team_score = home_team_score)', self.id, self.id)
  end

  def win_percentage
    if !self.all_matches.empty?
      (self.wins.length / self.all_matches.length) * 100
    else
      0
    end
  end

  # First Play Matches

  def first_played_bonus
    FIRST_PLAY_BONUS * self.all_matches.select('distinct home_team_id, away_team_id').length
  end

  # Handicap Matches
  def handicap_losses
    self.losses.where('created_at > ?', PHASE_TWO_DATE)
  end

  def handicap_ties
    self.losses.where('created_at > ?', PHASE_TWO_DATE)
  end

  # Point calculations

  def wins_plus_handicap
    self.wins.length * WIN_VALUE
  end

  def ties_plus_handicap
    self.handicap_ties.length * HANDICAP_TIE_BONUS +
      self.ties.length * TIE_VALUE
  end

  def losses_plus_handicap
    self.handicap_losses.length * HANDICAP_LOSS_BONUS
  end

  def total_points
     self.first_played_bonus +
      self.wins_plus_handicap +
      self.ties_plus_handicap +
      self.losses_plus_handicap
  end
end
