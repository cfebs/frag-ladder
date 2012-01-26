class Member < ActiveRecord::Base
  validates :alias, :presence => true

  belongs_to :team

  has_many :member_match_records
  has_many :matches, :through => :member_match_records

  def plus
    self.matches.where('home_team_id = ?', self.team_id).sum(:home_team_score) +
    self.matches.where('away_team_id = ?', self.team_id).sum(:away_team_score)
  end

  def minus
    self.matches.where('home_team_id = ?', self.team_id).sum(:away_team_score) +
    self.matches.where('away_team_id = ?', self.team_id).sum(:home_team_score)
  end

  def wins
    self.matches.where('(home_team_id = ? AND home_team_score > away_team_score)
      OR (away_team_id = ? AND away_team_score > home_team_score)', self.team_id, self.team_id)
  end

  def losses
    self.matches.where('(home_team_id = ? AND home_team_score < away_team_score)
      OR (away_team_id = ? AND away_team_score < home_team_score)', self.team_id, self.team_id)
  end

  def ties
    self.matches.where('(home_team_id = ? OR away_team_id = ?) AND (home_team_score = away_team_score)', self.team_id, self.team_id)
  end

  # maps
  def map_wins map
    self.wins.where('map_id = ?', map.id)
  end

  def map_losses map
    self.losses.where('map_id = ?', map.id)
  end

  def map_ties map
    self.ties.where('map_id = ?', map.id)
  end

  def map_all map
    self.matches.where('map_id = ?', map.id)
  end

  def get_plus_map map
    self.matches.where('map_id = ? AND (home_team_id = ?)', map.id, self.team_id).sum(:home_team_score) +
    self.matches.where('map_id = ? AND (away_team_id = ?)', map.id, self.team_id).sum(:away_team_score)
  end

  def get_minus_map map
    self.matches.where('map_id = ? AND (home_team_id = ?)', map.id, self.id).sum(:away_team_score) +
    self.matches.where('map_id = ? AND (away_team_id = ?)', map.id, self.id).sum(:home_team_score)

  end

end
